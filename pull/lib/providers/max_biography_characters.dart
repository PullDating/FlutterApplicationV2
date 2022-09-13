import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max number of characters that a biography is allowed to contain.
final maxBiographyLengthProvider = StateNotifierProvider<MaxBiographyLengthNotifier, int>((ref) {
  return MaxBiographyLengthNotifier();
});

class MaxBiographyLengthNotifier extends StateNotifier<int> {
  MaxBiographyLengthNotifier() : super(300);
  void set(int value) {
    state = value;
  }
}