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
          .loginRequest(await value.user!.getIdToken(),
          ref.read(phoneNumberProvider)!.completeNumber)
          .then((value) async
    {
      print("login request fired");
      print(value);
      //todo run the setup function to populate providers after they have successfully logged in.
      await setupBasicProviders(ref);
      print("done setup of basic providers");
      if (value == true) {
        await setupUserProviders(ref);
        context.go('/home');
      }
      else {
        //TODO update the context redirect here
        //{context.go('/createProfile/name')}
      }
    });
  } catch (e) {
  print(e);
  }
}
}
