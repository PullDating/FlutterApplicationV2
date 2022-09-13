import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

///returns the photos for the account creation in cm
final accountCreationPhotosProvider = StateNotifierProvider<AccountCreationPhotosNotifier, List<File>>((ref) {
  return AccountCreationPhotosNotifier();
});

class AccountCreationPhotosNotifier extends StateNotifier<List<File>> {
  AccountCreationPhotosNotifier() : super([]);
  void set(List<File> value) {
    state = value;
  }
}