import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max number of images that they are allowed to have in their profile
final maxProfileImageCountProvider = StateNotifierProvider<MaxProfileImageCountNotifier, int>((ref) {
  return MaxProfileImageCountNotifier();
});

class MaxProfileImageCountNotifier extends StateNotifier<int> {
  MaxProfileImageCountNotifier() : super(6);
  void set(int value) {
    state = value;
  }
}