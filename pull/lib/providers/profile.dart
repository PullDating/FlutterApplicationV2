import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull/models/profile.dart';

///returns the user's profile
final profileProvider = StateNotifierProvider<ProfileNotifier, Profile?>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<Profile?> {
  ProfileNotifier() : super(null);
  void set(Profile value) {
    state = value;
  }
}