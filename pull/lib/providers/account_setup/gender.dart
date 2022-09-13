import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the gender for the account creation.
final accountCreationGenderProvider = StateNotifierProvider<AccountCreationGenderNotifier, String?>((ref) {
  return AccountCreationGenderNotifier();
});

class AccountCreationGenderNotifier extends StateNotifier<String?> {
  AccountCreationGenderNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}