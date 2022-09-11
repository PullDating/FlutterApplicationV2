import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';
import 'package:pull/functions/firebase.dart';
import 'package:pull/providers/login/firebase_verification_id.dart';
import 'package:pull/providers/login/phone_number.dart';

class OneTimePasswordPage extends ConsumerStatefulWidget {
  const OneTimePasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OneTimePasswordPage> createState() => _OneTimePasswordPageState();
}

class _OneTimePasswordPageState extends ConsumerState<OneTimePasswordPage> {

  late String verificationID;
  late PhoneNumber phone;
  final TextEditingController _pinPutController = TextEditingController();


  @override
  void initState() {
    super.initState();
    phone = ref.read(phoneNumberProvider)!;
    verificationID = ref.read(firebaseVerificationIDProvider)!;
  }

  _submitted (String pin) async {

    if(ref.read(firebaseVerificationIDProvider) == null){
      throw Exception("verification ID from firebase was null when trying to call login.");
    }

    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: ref.read(firebaseVerificationIDProvider)!, smsCode: pin))
          .then((value) async {
        signOrLogIn(value, ref, context);
      });
    } catch (e){
      print(e);
    }
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    )
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SMS verification"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                "Verify Phone Number",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              useNativeKeyboard: true,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              length: 6,
              closeKeyboardWhenCompleted: false,
              defaultPinTheme: defaultPinTheme,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
              onSubmitted: (pin) => _submitted(pin),
            ),
          ),
        ],
      ),
    );
  }
}
