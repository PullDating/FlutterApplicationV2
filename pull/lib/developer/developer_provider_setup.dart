import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/developer/image_files.dart';
import 'package:pull/developer/profile_element_lists.dart';
import 'package:pull/models/chat.dart';
import 'package:pull/models/filter.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/models/message.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/filter.dart';
import 'package:pull/providers/match_list.dart';
import 'package:pull/providers/max_concurrent_matches.dart';
import 'package:pull/providers/network/auth_token.dart';
import 'package:pull/providers/network/uuid.dart';
import 'package:pull/providers/paused.dart';
import 'package:pull/providers/profile.dart';
import 'package:uuid/uuid.dart';

Future<void> setupDeveloperProviders (WidgetRef ref) async {
  print("Entered Developer Setup");




  print("Setting the uuid and auth token providers");
  //set the uuid provider and auth token providers
  ref.read(uuidProvider.notifier).set("not a real uuid");
  ref.read(authTokenProvider.notifier).set("not a real auth token");

  //set account paused provider
  ref.read(accountPausedProvider.notifier).set(false);

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

  //set up the filter provider
  Filter userFilter = Filter(
    btAverage: true,
    btLean: false,
    btMuscular: false,
    btHeavy: true,
    btObese: true,
    genderMan: false,
    genderWoman: true,
    genderNonBinary: false,
    maxAge: 25,
    minAge: 21,
    maxDistance: 15,
    maxHeight: 245,
    minHeight: 76,
  );

  ref.read(filterProvider.notifier).set(userFilter);


  print("attemping to set the match list");
  //set the match list provider..
  var uuid = Uuid();
  for(int i = 0; i < ref.read(maxConcurrentMatchesProvider)-1; i++){

    String newuuid = uuid.v4();
    PullMatch newMatch = PullMatch(
      chat: generateRandomChat(ref.read(uuidProvider)!, newuuid),
      person: await generateRandomProfile(newuuid),
    );
    ref.read(matchListProvider.notifier).add(newMatch);
  }
  print("done the developer provider setup.");
}

List<String> sample_biographies = [
  "I???m a sucker for love ??? I believe in love and I???m looking for my soulmate.",
  "I???m an independent woman ??? I am also strong and independent, and I don???t need anyone to take care of me.",
  "I???m a hopeless romantic, and I???m also looking for my fairytale ending.",
  "Travelling, adventures, extreme sports are also a vital part of me, but I like flattering and watching them rather than doing it?",
  "I love to laugh, and I???m also looking for someone who can make me laugh.",
  "Karaoke is my jam, and I???m looking for someone to sing duets with.",
  "I???m a little bit country, and I???m a little bit rock and roll.",
  "Do you like pi??a coladas? Getting caught in the rain? If so, we might just be the perfect match.",
  "I???m looking for someone to share my entire life with.",
  "Message me your best pick up line.",
  "Do not message me if you are not prepared for some serious sass.",
  "I???m looking for someone who can handle my sarcasm.",
];

Future<Person> generateRandomProfile(String uuid) async {
  var rng = Random();
  //generate a list of images
  List<File> sample_images = [];
  for(int j = 0; j < 3; j++){
    //generate a random image and append it to the list
    sample_images.add(await getFileFromURL(dev_image_urls[rng.nextInt(dev_image_urls.length)]));
  }

  String bio = sample_biographies[rng.nextInt(sample_biographies.length)];

  Person newperson = Person(
    uuid: uuid,
    age: (18 + rng.nextInt(40 - 18)).toInt(),
    distance: (rng.nextInt(50)),
    name: sample_names[rng.nextInt(sample_names.length)],
    images: sample_images,
    biography: bio,
  );

  return newperson;
}

Chat generateRandomChat(String uuid1, String uuid2, ) {
  //set the random variable.
  var rng = Random();
  //get a random number for the number of messages that will exist
  int numMessages = rng.nextInt(5);
  List<PullMessage> messages = [];
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

    PullMessage newMessage = generateRandomMessage(uuid, read, newTime);

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
  "You???re my favorite YouTuber. I wanna smash your like button and subscribe for the rest of my life.",
  "Did you hurt yourself when you fell from Heaven?",
  "I???m not a photographer, but I can picture me and you together.",
  "If you were a triangle, you???d be acute one!",
  "Are you an alien? Because you just abducted my heart.",
  "Hey, you???re pretty and I???m cute. Together we???d be Pretty Cute.",
  "I seem to have lost my phone number. Can I have yours?",
  "Is your name Google? Because you got everything I am searching for.",
  "Are you Australian? Because you meet all of my koalafications.",
  "If you were a Transformer you???d be Optimus Fine!",
  "Are you a parking ticket? Cause you???ve got fine written all over you!",
  "If I had to rate you from 1 to 10, I???d give you a 9, because I???m the 1 you???re missing.",
  "Well, here I am. What are your other two wishes?",
  "If you were a vegetable you???d be a cute cumber.",
];

PullMessage generateRandomMessage(String uuid, bool read, DateTime time){
  var rng = Random();
  //generate random index for the message out of sample_message_strings
  int sample_message_index = rng.nextInt(sample_message_strings.length);

  PullMessage newMessage = PullMessage(
    datetime: time,
    read: read,
    sender: uuid,
    message: sample_message_strings[sample_message_index],
  );
  return newMessage;
}


