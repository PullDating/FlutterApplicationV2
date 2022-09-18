import 'package:flutter_riverpod/flutter_riverpod.dart';

///determines if the application is in dev mode. In dev mode, the providers are fed with dummy data
///and much of the authentication logic is bypassed for convenience.
final developerModeProvider = StateNotifierProvider<DeveloperModeNotifier, bool>((ref) {
  return DeveloperModeNotifier();
});

class DeveloperModeNotifier extends StateNotifier<bool> {
  DeveloperModeNotifier() : super(false);
  void set(bool value) {
    state = value;
  }
}