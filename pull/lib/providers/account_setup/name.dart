import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the name for the account creation
final accountCreationNameProvider = StateNotifierProvider<AccountCreationNameNotifier, String?>((ref) {
  return AccountCreationNameNotifier();
});

class AccountCreationNameNotifier extends StateNotifier<String?> {
  AccountCreationNameNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}