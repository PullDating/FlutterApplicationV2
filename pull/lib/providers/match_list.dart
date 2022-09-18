//for the matches that they already have
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/pullmatch.dart';
import 'package:pull/models/person.dart';
import 'package:pull/providers/developer_mode.dart';

///returns the user's filters
final matchListProvider = StateNotifierProvider<MatchListNotifier, List<PullMatch>>((ref) {
  return MatchListNotifier(ref);
});

class MatchListNotifier extends StateNotifier<List<PullMatch>> {
  MatchListNotifier(this.ref) : super([]);
  StateNotifierProviderRef ref;

  void set(List<PullMatch> value) {
    state = value;
  }

  void add(PullMatch value){
    List<PullMatch> newList = [];
    newList.addAll(state);
    newList.add(value);
    state = newList;
  }
}