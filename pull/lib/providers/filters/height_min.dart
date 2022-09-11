import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the min height that the user is allowed to select in their filters, or set for their profile.
final minHeightProvider = StateNotifierProvider<MinHeightNotifier, int>((ref) {
  return MinHeightNotifier();
});

class MinHeightNotifier extends StateNotifier<int> {
  MinHeightNotifier() : super(55);
  void set(int value) {
    state = value;
  }
}