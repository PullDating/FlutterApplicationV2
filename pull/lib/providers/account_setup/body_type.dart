import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the body type for the account creation.
final accountCreationBodyTypeProvider = StateNotifierProvider<AccountCreationBodyTypeNotifier, String?>((ref) {
  return AccountCreationBodyTypeNotifier();
});

class AccountCreationBodyTypeNotifier extends StateNotifier<String?> {
  AccountCreationBodyTypeNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}