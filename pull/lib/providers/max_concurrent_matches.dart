import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max number of concurrent matches a person is allowed to have.
final maxConcurrentMatchesProvider = StateNotifierProvider<MaxConcurrentMatchesNotifier, int>((ref) {
  return MaxConcurrentMatchesNotifier();
});

class MaxConcurrentMatchesNotifier extends StateNotifier<int> {
  MaxConcurrentMatchesNotifier() : super(5);
  void set(int value) {
    state = value;
  }
}