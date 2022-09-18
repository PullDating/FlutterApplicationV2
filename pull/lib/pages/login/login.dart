import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pull/developer/developer_provider_setup.dart';
import 'package:pull/functions/firebase.dart';
import 'package:pull/providers/developer_mode.dart';
import 'package:pull/providers/login/firebase_verification_id.dart';
import 'package:pull/providers/login/phone_number.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  PhoneNumber? phoneNumber;

  _loginPressed() async {
    print("Login Pressed");

    if(phoneNumber != null){
      try{
        print("attemping to validate firebase auth.");
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber!.completeNumber,

          //android only SMS auto complete.
          verificationCompleted: (PhoneAuthCredential credential) async {
            print("using android auto SMS verification");
            //TODO hanlde this use case.
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              signOrLogIn(value, ref, context);
            });
          },

          verificationFailed: (FirebaseAuthException e) {
            print("firebase verification failed.");
            print(e);
          },

          codeSent: (String verificationId, int? resendToken) {
            print("SMS verification code sent...");
            //update the phone number provider with the number.
            ref.read(phoneNumberProvider.notifier).set(phoneNumber!);
            ref.read(firebaseVerificationIDProvider.notifier).set(verificationId);
            context.go('/login/one_time_password');
          },

          codeAutoRetrievalTimeout: (String verificationId){
            print("firebase auth auto retrieval timeout...");
          }

        );
      } catch (e) {
        print("failed to validate firebase");
        print(e);
      }
    } else {
      print("Phone number was null, abandoning login");
    }

  }
  _phoneNumberChanged(PhoneNumber phone){
    phoneNumber = phone;
    print("Phone number: " + phoneNumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/production/backgrounds/loginbackground.png"),
              fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36.0),
          child: Center(
            child: Column(
              children: [
                Text("Pull", style: Theme.of(context).textTheme.headline3,),
                SizedBox(
                  width: 250,
                  child: IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'US',
                    onChanged: (phone) => _phoneNumberChanged(phone),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                ),
                ElevatedButton(
                    onPressed: () => _loginPressed(),
                    child: const Text("Login")
                ),
                ElevatedButton(
                  onPressed: () async {
                    ref.read(developerModeProvider.notifier).set(true);
                    await setupDeveloperProviders(ref);
                    context.go('/home');
                  },
                  child: const Text("enter developer mode"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
