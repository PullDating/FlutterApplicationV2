import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/developer/image_files.dart';
import 'package:pull/developer/profile_element_lists.dart';
import 'package:pull/models/chat.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/models/message.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/match_list.dart';
import 'package:pull/providers/max_concurrent_matches.dart';
import 'package:pull/providers/network/auth_token.dart';
import 'package:pull/providers/network/uuid.dart';
import 'package:pull/providers/profile.dart';
import 'package:pull/providers/swiping/peopleProvider.dart';

Future<void> setupDeveloperProviders (WidgetRef ref) async {
  print("Entered Developer Setup");



  print("Setting the uuid and auth token providers");
  //set the uuid provider and auth token providers
  ref.read(uuidProvider.notifier).set("not a real uuid");
  ref.read(authTokenProvider.notifier).set("not a real auth token");

  print("attempint to get user profile images");
  List<File> userprofileimages = [
    await getFileFromURL(dev_image_urls[0]),
    await getFileFromURL(dev_image_urls[1]),
    await getFileFromURL(dev_image_urls[2]),
    await getFileFromURL(dev_image_urls[3]),
    await getFileFromURL(dev_image_urls[4]),
  ];
  print("creating user profile object");
  Profile userprofile = Profile(
    biography: "Hackerman is nothing compared to this guy...",
    birthdate: DateTime(2001,2,2),
    bodyType: 'average',
    datingGoal: 'hookup',
    gender: 'man',
    height: 200,
    latitude: 45.262079,
    longitude: -76.023783,
    name: "Eugene",
    uuid: "not a real uuid",
    images: userprofileimages
  );

  print("configuring the profile provider");
  //set the profile provider
  ref.read(profileProvider.notifier).set(userprofile);

  print("attemping to set the match list");
  //set the match list provider..
  for(int i = 0; i < ref.read(maxConcurrentMatchesProvider); i++){

    String newuuid = UniqueKey().toString();
    PullMatch newMatch = PullMatch(
      chat: generateRandomChat(ref.read(uuidProvider)!, newuuid),
      person: await generateRandomProfile(newuuid),
    );
    ref.read(matchListProvider.notifier).add(newMatch);
  }
  print("done the developer provider setup.");
}

Future<Person> generateRandomProfile(String uuid) async {
  var rng = Random();
  //generate a list of images
  List<File> sample_images = [];
  for(int j = 0; j < 5; j++){
    //generate a random image and append it to the list
    sample_images.add(await getFileFromURL(dev_image_urls[rng.nextInt(dev_image_urls.length)]));
  }

  Person newperson = Person(
  uuid: uuid,
  age: (18 + rng.nextInt(40 - 18)).toInt(),
  distance: (rng.nextInt(50)),
  name: sample_names[rng.nextInt(sample_names.length)],
  images: sample_images
  );

  return newperson;
}

Chat generateRandomChat(String uuid1, String uuid2, ) {
  //set the random variable.
  var rng = Random();
  //get a random number for the number of messages that will exist
  int numMessages = rng.nextInt(5);
  List<Message> messages = [];
  //populate the messages list with some dummy data
  DateTime prevTime = DateTime.now().subtract(const Duration(days: 50));

  for(int i = 0; i < numMessages; i++){
    bool randombool = rng.nextBool();
    //determine which uuid is sending the message
    String uuid;
    if(randombool){
      uuid = uuid1;
    }else{
      uuid = uuid2;
    }
    //check to see if it's the last message and if so, then set read to false
    bool read;
    if(i == numMessages-1){
      read = false;
    } else {
      read = true;
    }

    //get a time greater than the last entry by some random amount.
    int days = rng.nextInt(4);
    int hours = rng.nextInt(10);
    DateTime newTime = prevTime.add(Duration(days: days, hours: hours));

    Message newMessage = generateRandomMessage(uuid, read, newTime);

    messages.add(newMessage);
    prevTime = newTime;
  }

  Chat newChat = Chat(
    roomid: "not a real room id",
    messages: messages,
  );

  return newChat;

}

List<String> sample_message_strings = [
  "Hey ;)",
  "You’re my favorite YouTuber. I wanna smash your like button and subscribe for the rest of my life.",
  "Did you hurt yourself when you fell from Heaven?",
  "I’m not a photographer, but I can picture me and you together.",
  "If you were a triangle, you’d be acute one!",
  "Are you an alien? Because you just abducted my heart.",
  "Hey, you’re pretty and I’m cute. Together we’d be Pretty Cute.",
  "I seem to have lost my phone number. Can I have yours?",
  "Is your name Google? Because you got everything I am searching for.",
  "Are you Australian? Because you meet all of my koalafications.",
  "If you were a Transformer you’d be Optimus Fine!",
  "Are you a parking ticket? Cause you’ve got fine written all over you!",
  "If I had to rate you from 1 to 10, I’d give you a 9, because I’m the 1 you’re missing.",
  "Well, here I am. What are your other two wishes?",
  "If you were a vegetable you’d be a cute cumber.",
];

Message generateRandomMessage(String uuid, bool read, DateTime time){
  var rng = Random();
  //generate random index for the message out of sample_message_strings
  int sample_message_index = rng.nextInt(sample_message_strings.length);

  Message newMessage = Message(
    datetime: time,
    read: read,
    sender: uuid,
    message: sample_message_strings[sample_message_index],
  );
  return newMessage;
}


