import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the minimum number of images they are allowed to have in their profile
final minProfileImageCountProvider = StateNotifierProvider<MinProfileImageCountNotifier, int>((ref) {
  return MinProfileImageCountNotifier();
});

class MinProfileImageCountNotifier extends StateNotifier<int> {
  MinProfileImageCountNotifier() : super(3);
  void set(int value) {
    state = value;
  }
}