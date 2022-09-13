import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the dating goal for the account creation.
final accountCreationDatingGoalProvider = StateNotifierProvider<AccountCreationDatingGoalNotifier, String?>((ref) {
  return AccountCreationDatingGoalNotifier();
});

class AccountCreationDatingGoalNotifier extends StateNotifier<String?> {
  AccountCreationDatingGoalNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}