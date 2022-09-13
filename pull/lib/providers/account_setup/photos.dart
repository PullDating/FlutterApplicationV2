import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the photos for the account creation in cm
final accountCreationPhotosProvider = StateNotifierProvider<AccountCreationPhotosNotifier, List<Image>>((ref) {
  return AccountCreationPhotosNotifier();
});

class AccountCreationPhotosNotifier extends StateNotifier<List<Image>> {
  AccountCreationPhotosNotifier() : super([]);
  void set(List<Image> value) {
    state = value;
  }
}