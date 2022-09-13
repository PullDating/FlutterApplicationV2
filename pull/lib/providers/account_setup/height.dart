import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/providers/filters/height_max.dart';
import 'package:pull/providers/filters/height_min.dart';

///returns the height for the account creation in cm
final accountCreationHeightProvider = StateNotifierProvider<AccountCreationHeightNotifier, int>((ref) {
  return AccountCreationHeightNotifier(ref);
});

class AccountCreationHeightNotifier extends StateNotifier<int> {
  AccountCreationHeightNotifier(ref) : super(
      ((ref.watch(maxHeightProvider) + ref.watch(minHeightProvider)) / 2).round()
  );
  void set(int value) {
    state = value;
  }
}