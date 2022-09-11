import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the user's auth token
final authTokenProvider = StateNotifierProvider<AuthTokenNotifier, String?>((ref) {
  return AuthTokenNotifier();
});

class AuthTokenNotifier extends StateNotifier<String?> {
  AuthTokenNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}