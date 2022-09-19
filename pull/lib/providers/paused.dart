import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the minimum number of images they are allowed to have in their profile
final accountPausedProvider = StateNotifierProvider<AccountPausedNotifier, bool>((ref) {
  return AccountPausedNotifier();
});

class AccountPausedNotifier extends StateNotifier<bool> {
  AccountPausedNotifier() : super(false);
  void set(bool value) {
    state = value;
  }
}