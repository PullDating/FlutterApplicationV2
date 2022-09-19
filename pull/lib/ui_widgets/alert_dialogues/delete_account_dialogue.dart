import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull/ui_widgets/alert_dialogues/delete_account_reason_dialogue.dart';
import 'package:pull/ui_widgets/alert_dialogues/report_dialogue.dart';

class DeleteAccountDialogue extends StatelessWidget {
  const DeleteAccountDialogue({Key? key}) : super(key: key);

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
          Text("")
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context,"delete");
            showDialog(context: context, builder: (context){
              return DeleteAccountReasonDialogue();
            });

          },
          child: Text("Yes, delete my account."),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context,"cancel");
          },
          child: Text("Cancel"),
        ),
      ],


    );
  }
}
