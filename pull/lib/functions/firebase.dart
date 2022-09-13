import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/functions/provider_setup.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/login/phone_number.dart';

Future<void> signOrLogIn(UserCredential value, WidgetRef ref,
    BuildContext context) async {
  if (value.user != null) {
    try {
      PullRepository repo = PullRepository(ref.read);
      print("about to send login request");

      if (ref.read(phoneNumberProvider) == null) {
        throw Exception(
            "The phone number provider was null when the sign in request attempt was made.");
      }

      await repo
          .login(await value.user!.getIdToken(),
          ref.read(phoneNumberProvider)!.completeNumber)
          .then((value) async
    {
      //todo run the setup function to populate providers after they have successfully logged in.
      await setupBasicProviders(ref);
      if (value == true) {
        await setupUserProviders(ref);
        //go to the home page
        context.go('/home');
      }
      else {
        //go to the account creation flow.
        context.go('/accountcreation');
        //{context.go('/createProfile/name')}
      }
    });
  } catch (e) {
    print(e);
  }
}
}
