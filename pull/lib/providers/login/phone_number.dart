import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/phone_number.dart';

///returns the intl phone number from the login field
final phoneNumberProvider = StateNotifierProvider<PhoneNumberNotifier, PhoneNumber?>((ref) {
  return PhoneNumberNotifier();
});

class PhoneNumberNotifier extends StateNotifier<PhoneNumber?> {
  PhoneNumberNotifier() : super(null);
  void set(PhoneNumber number) {
    state = number;
  }
}