import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/functions/image_utils.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/api_uris.dart';
import 'package:pull/providers/max_profile_image_count.dart';
import 'package:pull/providers/min_profile_image_count.dart';
import 'package:pull/providers/network/auth_token.dart';
import 'package:pull/providers/network/uuid.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:pull/providers/profile.dart';

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
    print("uuid: ${_uuid}");
    if(targetUUID != null){
      headers.addAll({"target" : targetUUID});
    }
    http.Response response = await http.get(profileUri, headers: headers);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

      //handling images
      List<Image> images = await getImagesFromImagePath(json['imagePath']);

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
        height: double.parse(json['height'].toString()),
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

  Future<void> createProfile() async {
    var request = http.MultipartRequest('POST', profileUri);
    request.headers.addAll(_authHeader);
    List<http.MultipartFile> filesToUpload = [];
    int numFilled = _read(profileProvider)!.images.length;

    if(numFilled > _read(minProfileImageCountProvider) || numFilled < _read(maxProfileImageCountProvider)){
      throw Exception("Invalid number of photos to create profile");
    }

    for(int i = 0; i < numFilled; i++){
      File tempfile = await saveImageToFile(_read(profileProvider)!.images[i]!);
      http.MultipartFile multifile = await http.MultipartFile.fromPath('photos',tempfile.path);
      filesToUpload.add(multifile);
    }

    request.files.addAll(filesToUpload);

    var uuid = _uuid;
    request.fields.addAll(uuid);

    String? name = _read(profileProvider)!.name;
    if(name != null){
      request.fields['name']= name;
    }else{
      throw Exception("name was not provided.");
    }

    DateTime? birthDate = _read(profileProvider)!.birthdate;
    if(birthDate != null){
      request.fields['birthDate']= birthDate.toString();
    }else{
      throw Exception("birthDate was not provided.");
    }

    String? gender = _read(profileProvider)!.gender;
    if(gender != null){
      request.fields['gender']= gender;
    }else{
      throw Exception("gender was not provided.");
    }

    double? height = _read(profileProvider)!.height;
    if(height != null){
      request.fields['height'] = height.toString();
    }else{
      throw Exception("height was not provided.");
    }

    String? datingGoal = _read(profileProvider)!.datingGoal;
    if(datingGoal != null){
      request.fields['datingGoal'] = datingGoal;
    } else {
      throw Exception("datingGoal was not provided.");
    }

    String? biography = _read(profileProvider)!.biography;
    if(biography != null){
      request.fields['biography'] = biography;
    } else {
      throw Exception("biography was not provided.");
    }

    String? bodyType = _read(profileProvider)!.bodyType;
    if(bodyType != null){
      request.fields['bodyType'] = bodyType;
    } else {
      throw Exception("bodyType was not provided");
    }

    double? longitude = _read(profileProvider)!.longitude;
    if(longitude != null){
      request.fields["longitude"] = longitude.toString();
    }else{
      throw Exception("longitude was not provided.");
    }

    double? latitude = _read(profileProvider)!.latitude;
    if(latitude != null){
      request.fields['latitude'] = latitude.toString();
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

  Future<void> updateProfile(List<int> change_photos, Profile newprofile) async {
    var request = http.MultipartRequest('PUT', profileUri);
    List<http.MultipartFile> filesToUpload = [];
    int numFilled = newprofile.images.length;
    if(numFilled > _read(minProfileImageCountProvider) || numFilled < _read(maxProfileImageCountProvider)){
      throw Exception("You cannot update a profile to have an invalid number of photos.");
    }

    try{
      print("numfilled: ${numFilled}");
      print("change_photos length: ${change_photos.length}");
      for(int i = 0; i < numFilled; i++){
        //if at position i, there is a -1 in the change_photos, do we want to upload it.
        if(change_photos[i] == -1){
          File tempfile = await saveImageToFile(newprofile.images[i]!);
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
      changePhotoJson.addAll({"\"${i}\"" : "\"${change_photos.elementAt(i)}\""});
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
      print("filter get values");
      print(jsonDecode(response.body));
      Filter filters = Filter.fromJson(jsonDecode(response.body));
      return filters;
    } else {
      throw Exception("Error trying to get filters from server.");
    }
  }

  //helper functions

  Future<List<Image>> getImagesFromImagePath(Map<String,dynamic> imagePath) async {
    imagePath.remove('bucket');
    int length = imagePath.keys.length;
    List<Image> images = [];

    for(String element in imagePath.keys){
      try{
        images.add(getImageFromURL(imagePath[element]!));
      } catch (e) {
        print(e);
        throw Exception("Couldn't get image from imagePath");
      }
    }
    return images;
  }

  Image getImageFromURL(String presignedUrl){
    try{
      //Uri presignedUri = Uri.parse(presignedUrl);
      return Image.network(presignedUrl);
    } catch (e) {
      print(e);
      throw Exception("Couldn't get the file from the url given.");
    }
  }

}