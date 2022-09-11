import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the intl phone number from the login field
final firebaseVerificationIDProvider = StateNotifierProvider<firebaseVerificationIDNotifier, String?>((ref) {
  return firebaseVerificationIDNotifier();
});

class firebaseVerificationIDNotifier extends StateNotifier<String?> {
  firebaseVerificationIDNotifier() : super(null);
  void set(String id) {
    state = id;
  }
}