import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the user's uuid
final uuidProvider = StateNotifierProvider<UUIDNotifier, String?>((ref) {
  return UUIDNotifier();
});

class UUIDNotifier extends StateNotifier<String?> {
  UUIDNotifier() : super(null);
  void set(String value) {
    state = value;
  }
}