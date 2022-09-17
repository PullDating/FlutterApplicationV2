import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/exceptions/empty_get_people_request.dart';
import 'package:pull/models/person.dart';
import 'package:pull/models/profile.dart';
import 'package:pull/network/pull_api/repository.dart';
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
    print("Add called on people notifier");
    PullRepository repo = PullRepository(ref.read);
    int lengthPrior = state.length;
    //todo add a way to exclude the people that you already have in the stack in this request.
    try {
      List<Person> values = await repo.getPeople(num);
      state.addAll(values);
      print("added people to the list of values.");
    } on EmptyGetPeopleException catch (e){
      print("no more people to get");
      //this is fine.
    }
    int lengthAfter = state.length;
    if(state.isEmpty || lengthAfter != lengthPrior + num){
      print("Couldn't find anyone, or couldn't find enough.");
      //this means that it failed the search, thus wait a delay
      Timer(const Duration(seconds: 300), () {
        print("Waiting because we ran out of people in the repo...");
        add(num);
      });
    }
  }
  ///removes the first item from the list (the one the user swiped)
  Future<void> remove() async {
    state.removeAt(0);
    if(state.isEmpty){
      //get more if you can.
      await add(ref.read(peopleCountTargetProvider));
    } else if (state.length < ref.read(peopleCountTargetProvider)){
      await add(ref.read(peopleCountTargetProvider) - state.length);
    }
  }
  ///resets the list (used when changing filters, for example)
  void reset(){
    state = [];
  }
}