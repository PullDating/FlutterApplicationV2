import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull/network/pull_api/repository.dart';
import 'package:pull/providers/login/phone_number.dart';

Future<void> signOrLogIn(
    UserCredential value, WidgetRef ref, BuildContext context) async {
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
          .then((value) => {
                print("login request fired"),
                print(value),
                if (value == true)
                  {
                    {context.go('/home')}
                  }
                else
                  {
                    //TODO update the context redirect here
                    //{context.go('/createProfile/name')}
                  }
              });
    } catch (e) {
      print(e);
    }
  }
}
