import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/api_uris.dart';
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

  ///Api request to login the user. Takes the validationID and the phone number and returns boolean on whether
  ///the user was already logged is new (false) or not (true)
  Future<bool> loginRequest(String idToken, String phone) async {
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
      //ref.read(AccountCreationProvider.notifier).setProfile(profile);
      //instead return the profile.
    } else {
      print("Error trying to get filters.");
      throw Exception("Error trying to get filters from server");
    }
  }

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