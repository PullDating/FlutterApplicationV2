import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteAccountReasonDialogue extends StatelessWidget {
  const DeleteAccountReasonDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        children: [
          Text("Delete Account")
        ],
      ),
      content: Column(
        children: [
          //todo actually keep track of ip and old account information to enforce this.
          Text("Are you sure? This action cannot be undone, and we keep track of the IP and phone numbers of deleted accounts to prevent resetting.")
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
          },
          child: Text("Found my person :)"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Ran out of options"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("App Design bugged me"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Too many toxic people"),
        ),
      ],


    );
  }
}