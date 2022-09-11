import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the max age that the user is allowed to select in their filters, or set for their profile
final maxAgeProvider = StateNotifierProvider<MaxAgeNotifier, int>((ref) {
  return MaxAgeNotifier();
});

class MaxAgeNotifier extends StateNotifier<int> {
  MaxAgeNotifier() : super(100);
  void set(int value) {
    state = value;
  }
}