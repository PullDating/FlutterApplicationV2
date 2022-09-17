import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the ideal number of people they should have cached in [peopleProvider]
final peopleCountTargetProvider = StateNotifierProvider<PeopleCountTargetNotifier, int>((ref) {
  return PeopleCountTargetNotifier();
});

class PeopleCountTargetNotifier extends StateNotifier<int> {
  PeopleCountTargetNotifier() : super(5);

  void set(int value) {
    state = value;
  }
}