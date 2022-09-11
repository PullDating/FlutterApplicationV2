import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max height that the user is allowed to select in their filters, or set for their profile.
final maxHeightProvider = StateNotifierProvider<MaxHeightNotifier, int>((ref) {
  return MaxHeightNotifier();
});

class MaxHeightNotifier extends StateNotifier<int> {
  MaxHeightNotifier() : super(275);
  void set(int value) {
    state = value;
  }
}