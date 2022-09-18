import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/developer/developer_provider_setup.dart';
import 'package:pull/developer/image_files.dart';
import 'package:pull/developer/profile_element_lists.dart';
import 'package:pull/exceptions/empty_get_people_request.dart';
import 'package:pull/models/person.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/developer_mode.dart';
import 'package:pull/providers/swiping/people_count_target.dart';

///returns the people that they are allowed to swipe on.
final peopleProvider = StateNotifierProvider<PeopleNotifier, List<Person>>((ref) {
  return PeopleNotifier(ref);
});

class PeopleNotifier extends StateNotifier<List<Person>> {
  PeopleNotifier(this.ref) : super([]);
  StateNotifierProviderRef ref;
  ///add a single profile, input is number you want to add.
  Future<void> add(int num) async {
    if(!ref.read(developerModeProvider)) {
      //non developer mode
      print("Add called on people notifier");
      PullRepository repo = PullRepository(ref.read);
      int lengthPrior = state.length;
      //todo add a way to exclude the people that you already have in the stack in this request.
      try {
        List<Person> values = await repo.getPeople(num);
        //need to do this for immutability so that it notifies.
        List<Person> newlist = [];
        newlist.addAll(state);
        newlist.addAll(values);
        state = newlist;
        print(state);
        print("added people to the list of values.");
      } on EmptyGetPeopleException catch (e) {
        print("no more people to get");
        //this is fine.
      }

      print("new Length of people list: " + state.length.toString());

      int lengthAfter = state.length;
      if ((state.isEmpty || lengthAfter != lengthPrior + num) &&
          state.length < ref.read(peopleCountTargetProvider)) {
        print("Couldn't find anyone, or couldn't find enough.");
        //this means that it failed the search, thus wait a delay
        Timer(const Duration(seconds: 30), () {
          print("Waiting because we ran out of people in the repo...");
          add(num);
        });
      }
      print("returning from add call to people");



    } else {
      //if in developer mode
      List<Person> new_people = [];
      new_people.addAll(state);
      List<Person> dev_people = [];
      for(int i = 0; i < num; i++){
        String newuuid = UniqueKey().toString();
        dev_people.add(await generateRandomProfile(newuuid));
      }
      new_people.addAll(dev_people);
      state = new_people;
    }
  }
  ///removes the first item from the list (the one the user swiped)
  Future<void> remove() async {
    List<Person> temp = state;
    temp.removeAt(0);
    state = temp;
    if(state.isEmpty){
      //get more if you can.
      await add(ref.read(peopleCountTargetProvider));
    } else if (state.length < ref.read(peopleCountTargetProvider)){
      await add(ref.read(peopleCountTargetProvider) - state.length);
    }
  }
  ///resets the list (used when changing filters, for example)
  void reset(){
    List<Person> temp = [];
    state = temp;
  }
}