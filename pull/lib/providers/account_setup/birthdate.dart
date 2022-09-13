import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the birthdate for account creation.
final accountCreationBirthDateProvider = StateNotifierProvider<AccountCreationBirthDateNotifier, DateTime?>((ref) {
  return AccountCreationBirthDateNotifier();
});

class AccountCreationBirthDateNotifier extends StateNotifier<DateTime?> {
  AccountCreationBirthDateNotifier() : super(null);
  void set(DateTime value) {
    state = value;
  }
}