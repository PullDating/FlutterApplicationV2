import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull/exceptions/empty_get_people_request.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/api_uris.dart';
import 'package:pull/providers/max_profile_image_count.dart';
import 'package:pull/providers/min_profile_image_count.dart';
import 'package:pull/providers/network/auth_token.dart';
import 'package:pull/providers/network/uuid.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class PullRepository {
  PullRepository(this._read);
  final Reader _read;

  //getters for headers from providers.

  /// Derive an auth header from [authTokenProvider]
  Map<String, String> get _authHeader {
    final token = _read(authTokenProvider);
    if(token != null){
      return {"Authorization" : 'Bearer $token'};
    }else{
      throw Exception("couldn't retrieve the Authorization Token from provider.");
    }
  }

  /// Derive a uuid header from [uuidProvider]
  Map<String, String> get _uuid {
    final uuid = _read(uuidProvider);
    if(uuid != null){
      return {"uuid" : uuid};
    } else {
      throw Exception("Couldn't get the uuid from provider.");
    }
  }

  //endpoint functions

  ///Api request to login the user. Takes the validationID and the phone number and returns boolean on whether
  ///the user was new (false) or not (true)
  Future<bool> login(String idToken, String phone) async {
    var request = http.Request('GET', loginUri);
    request.headers.addAll({"id" : idToken, "phone" : phone});
    var streamedResponse = await request.send().timeout(const Duration(seconds: 5));
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200){
      final Map parsed = json.decode(response.body);
      //TODO set the returned uuid and auth token in hive.
      //set the relevant providers.
      _read(authTokenProvider.notifier).set(parsed['token']);
      _read(uuidProvider.notifier).set(parsed['uuid']);

      //determine if the user is new or returning
      if(parsed['state'] == 0){
        //they are a new user (state 0 means they just made an account)
        return false;
      } else {
        //they are a returning user.
        return true;
      }

    }else{
      print("Something's wrong");
      print(response);
      throw Exception('Login attempt failed.');
    }
  }

  //profile

  ///gets a profile from the API. If [targetUUID] is null, then it uses the uuid from the current user
  ///else it gets the uuid specified.
  Future<Profile> getProfile( String? targetUUID) async {
    Map<String,String> headers = {};
    headers.addAll(_authHeader);
    headers.addAll(_uuid);
    print("uuid: $_uuid");
    if(targetUUID != null){
      headers.addAll({"target" : targetUUID});
    }
    http.Response response = await http.get(profileUri, headers: headers);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

      //handling images
      List<File> images = await getFilesFromImagePath(json['imagePath']);

      var coordinates = json['lastLocation']['coordinates'];

      //convert the birthDates to ages
      DateTime birthdate = DateTime.parse(json['birthDate']);

      //create a profile object using the values.
      Profile profile = Profile(
        uuid: (targetUUID == null)? _read(uuidProvider)! : targetUUID,
        name: json['name'],
        birthdate: birthdate,
        bodyType: json['bodyType'],
        gender: json['gender'],
        height: int.parse(json['height'].toString()),
        datingGoal: json['datingGoal'],
        biography: json['biography'],
        latitude: double.parse(coordinates[0].toString()),
        longitude: double.parse(coordinates[1].toString()),
        images: images,
      );
      return profile;
    } else {
      print("Error trying to get filters.");
      throw Exception("Error trying to get filters from server");
    }
  }

  Future<List<Person>> getPeople(int number) async {
    Map<String,String> headers = {};
    headers.addAll(_authHeader);
    headers.addAll(_uuid);
    headers.addAll({"number" : number.toString()});

    http.Response response = await http.get(peopleUri, headers: headers);

    if(response.statusCode == 200){
      print('valid response code');
      print(jsonDecode(response.body));
      var res = jsonDecode(response.body);
      List<dynamic> result = res['returnList'];
      print(result);
      List<Person> returnList = [];
      DateTime now = DateTime.now();


      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        var res = result[i];
        Profile profile = await getProfile(res['uuid']);

        int age;
        try {
          age = now
              .difference(profile.birthdate)
              .inDays ~/ 365;
        } catch (e) {
          print(e);
          throw("age cast failed");
        }

        int distance;
        try {
          distance = (res['distance'] as double).toInt();
        } catch(e){
          print(e);
          throw("distance cast failed");
        }

        //todo add the option to not have certain personal info displayed.
        //convert the profile to a person object for display
        Person person = Person(
          uuid: profile.uuid,
          age: age,
          distance: distance,
          name: profile.name,
          gender: profile.gender,
          bodyType: profile.bodyType,
          height: profile.height,
          biography: profile.biography,
        );
        returnList.add(person);
      }

      return returnList;
    } else if (response.statusCode == 201){
      //this means it could not find anyone.
      //maybe throw a custom exception?
      throw EmptyGetPeopleException();
    } else {
      print("Error trying to get filters.");
      throw Exception("Error trying to get filters from server");
    }
  }

  Future<void> createProfile(Profile profile) async {
    var request = http.MultipartRequest('POST', profileUri);
    request.headers.addAll(_authHeader);
    List<http.MultipartFile> filesToUpload = [];
    int numFilled = profile.images.length;

    if(numFilled < _read(minProfileImageCountProvider) || numFilled > _read(maxProfileImageCountProvider)){
      throw Exception("Invalid number of photos to create profile");
    }

    for(int i = 0; i < numFilled; i++){

      try{
        File tempfile = profile.images[i]!;
        http.MultipartFile multifile = await http.MultipartFile.fromPath('photos',tempfile.path);
        filesToUpload.add(multifile);
      } catch (e) {
        print(e);
        throw Exception("Couldn't create multipart file from file");
      }
    }

    request.files.addAll(filesToUpload);

    var uuid = _uuid;
    request.fields.addAll(uuid);

    String name = profile.name;
    request.fields['name']= name;

    DateTime birthDate = profile.birthdate;
    request.fields['birthDate']= birthDate.toString();


    String gender = profile.gender;
    request.fields['gender']= gender;


    int height = profile.height;
    request.fields['height'] = height.toString();


    String datingGoal = profile.datingGoal;
    request.fields['datingGoal'] = datingGoal;


    String biography = profile.biography;
    request.fields['biography'] = biography;

    String bodyType = profile.bodyType;
    request.fields['bodyType'] = bodyType;

    double longitude = profile.longitude;
    request.fields["longitude"] = longitude.toString();

    double latitude = profile.latitude;
    request.fields['latitude'] = latitude.toString();

    try {
      print("attemping to send the create Profile request.");
      var response = await request.send().timeout(const Duration(seconds: 3));
      if(response.statusCode == 200){
        print("Success");
      }else{
        print("Something wrong");
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      print(e);
      throw Exception("Timeout trying to send the create profile request.");
    } on Error catch (e) {
      print('Error: $e');
      throw Exception("Error trying to send the create profile request. (general error)");
    } catch (e) {
      print(e);
      throw Exception("General exception trying to create the profile request.");
    }
  }

  Future<void> updateProfile(List<int> change_photos, Profile newprofile) async {
    var request = http.MultipartRequest('PUT', profileUri);
    List<http.MultipartFile> filesToUpload = [];
    int numFilled = newprofile.images.length;
    if(numFilled > _read(minProfileImageCountProvider) || numFilled < _read(maxProfileImageCountProvider)){
      throw Exception("You cannot update a profile to have an invalid number of photos.");
    }

    try{
      print("numfilled: $numFilled");
      print("change_photos length: ${change_photos.length}");
      for(int i = 0; i < numFilled; i++){
        //if at position i, there is a -1 in the change_photos, do we want to upload it.
        if(change_photos[i] == -1){
          File tempfile = newprofile.images[i]!;
          http.MultipartFile multifile = await http.MultipartFile.fromPath('photos', tempfile.path);
          filesToUpload.add(multifile);
        }
      }
      //append the image files to the request.
      request.files.addAll(filesToUpload);
    } catch (e){
      print(e);
      throw Exception("problem adding the images to the put profile request.");
    }
    //add the uuid to the request
    //todo modify the endpoint to accept the uuid in the header instead of in the body.
    var uuid = _uuid;
    request.fields.addAll(uuid);

    //add the reorderphotos functionality. Convert the list to json first.
    Map<String, String> changePhotoJson = {};
    for(int i = 0; i < change_photos.length; i++){
      changePhotoJson.addAll({"\"$i\"" : "\"${change_photos.elementAt(i)}\""});
    }

    print("change Photo Json string");
    print(changePhotoJson);

    request.fields.addAll({"change_photos" : changePhotoJson.toString()});

    String? gender = newprofile.gender;
    if(gender != null){
      request.fields['gender']= gender;
    }else{
      throw Exception("gender was not provided.");
    }

    String? datingGoal = newprofile.datingGoal;
    if(datingGoal != null){
      request.fields['datingGoal'] = datingGoal;
    } else {
      throw Exception("datingGoal was not provided.");
    }

    String? biography = newprofile.biography;
    if(biography != null){
      request.fields['biography'] = biography;
    } else {
      throw Exception("biography was not provided.");
    }

    String? bodyType = newprofile.bodyType;
    if(bodyType != null){
      request.fields['bodyType'] = bodyType;
    } else {
      throw Exception("bodyType was not provided");
    }

    try {
      var response = await request.send().timeout(const Duration(seconds: 3));
      if(response.statusCode == 200){
        print("Success");
      }else{
        print("Something wrong");
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      print(e);
    } on Error catch (e) {
      print('Error: $e');
    }

  }

  //filter
  Future<Filter> getFilter() async {
    Map<String,String> headers = {};
    headers.addAll(_authHeader);
    headers.addAll(_uuid);
    http.Response response = await http.get(filterUri, headers: headers);
    if(response.statusCode == 200){

      try {
        print("filter get values");
        print(jsonDecode(response.body));
        Map<String, dynamic> results = jsonDecode(response.body);
        print(results);

        Filter filters = Filter.fromJson(jsonDecode(response.body));
        return filters;
      } catch (e) {
        print(e);
        throw Exception("Couldn't create filter instance AFTER getting information from server.");
      }
    } else {
      throw Exception("Error trying to get filters from server.");
    }
  }

  Future<void> createFilter(Filter filter) async {
    //calculate the correct date values based on the inputted ages.
    //DateTime currentDate = DateTime.now();
    //DateTime minBirthDate = DateTime(currentDate.year - filters.upperAge, currentDate.month, currentDate.day);
    //DateTime maxBirthDate = DateTime(currentDate.year - filters.lowerAge, currentDate.month, currentDate.day);

    Map<String,String> headers = {};
    headers.addAll(_authHeader);
    headers.addAll(_uuid);
    headers.addAll({"content-type" : "application/json"});

    //create the request.
    var response = await http.post(
        filterUri,
        body: jsonEncode(<String,String>
        {
          "minAge" : filter.minAge.toString(),
          "maxAge" : filter.maxAge.toString(),
          "minHeight" : filter.minHeight.toString(),
          "maxHeight" : filter.maxHeight.toString(),
          "genderMan" : filter.genderMan.toString(),
          "genderWoman" : filter.genderWoman.toString(),
          "genderNonBinary" : filter.genderNonBinary.toString(),
          "btLean" : filter.btLean.toString(),
          "btAverage" : filter.btAverage.toString(),
          "btMuscular" : filter.btMuscular.toString(),
          "btHeavy" : filter.btHeavy.toString(),
          "btObese" : filter.btObese.toString(),
          "maxDistance" : filter.maxDistance.toString(),
        }
        ),
        headers: headers
    );

    //interpret the response.
    if(response.statusCode == 200){
      print("Success");
      final Map parsed = json.decode(response.body);
      print(parsed['message']);
      return;
    }else{
      print("Something's wrong");
      print(response);
      throw Exception("Error sending filter information to the server.");
      return;
    }
  }


  //helper functions

  Future<List<File>> getFilesFromImagePath(Map<String,dynamic> imagePath) async {
    imagePath.remove('bucket');
    int length = imagePath.keys.length;
    List<File> images = [];
    for(String element in imagePath.keys){
      try{
        images.add(await getFileFromURL(imagePath[element]!));
      } catch (e) {
        print(e);
        throw Exception("Couldn't get image from imagePath");
      }
    }
    return images;
  }

  Future<File> getFileFromURL(String presignedUrl) async {
    try{

      print("trying to get image from presigned url: " + presignedUrl);

      //generate random number.
      var rng = new Random();

      //get temporary directory of device.
      Directory tempDir = await getTemporaryDirectory();

      //get temporary path from the temp directory
      String tempPath = tempDir.path;

      //create a new file in temporary path with random file name.
      File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.webp');

      //create uri from the presigned url
      Uri imageUri = Uri.parse(presignedUrl);

      //call http.get method and pass imageUrl into it to get respose.
      http.Response response = await http.get(imageUri);

      //write the body bytes to file
      await file.writeAsBytes(response.bodyBytes);

      //now return the file which is created with random name in temp location
      return file;
    } catch (e) {
      print(e);
      throw Exception("Couldn't get the file from the url given.");
    }
  }

}