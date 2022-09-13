import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max distance that the user is allowed to select in their filters
final maxDistanceProvider = StateNotifierProvider<MaxDistanceNotifier, int>((ref) {
  return MaxDistanceNotifier();
});

class MaxDistanceNotifier extends StateNotifier<int> {
  MaxDistanceNotifier() : super(100);
  void set(int value) {
    state = value;
  }
}