import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportDialogue extends StatelessWidget {
  const ReportDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        children: [
          Text("What justified this report?")
        ],
      ),
      content: Column(
        children: [
          Text("Note that this is only for serious offences. If it is simply a matter of preference, please unmatch instead. We take user reports seriously and use them to filter out scammers and predatory users.")
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {  },
          child: Text("Scam/Fraud"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Catfishing"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Harassment"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Criminal activity"),
        ),
      ],


    );
  }
}
