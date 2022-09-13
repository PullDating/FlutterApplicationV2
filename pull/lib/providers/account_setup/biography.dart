import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the biography for the account creation.
final accountCreationBiographyProvider = StateNotifierProvider<AccountCreationBiographyNotifier, String?>((ref) {
  return AccountCreationBiographyNotifier();
});

class AccountCreationBiographyNotifier extends StateNotifier<String?> {
  AccountCreationBiographyNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}