import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the min age that the user is allowed to select in their filters, or set for their profile
final minAgeProvider = StateNotifierProvider<MinAgeNotifier, int>((ref) {
  return MinAgeNotifier();
});

class MinAgeNotifier extends StateNotifier<int> {
  MinAgeNotifier() : super(18);
  void set(int value) {
    state = value;
  }
}