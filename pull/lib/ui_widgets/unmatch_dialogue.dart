import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnmatchDialogue extends StatelessWidget {
  const UnmatchDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        children: [
          Text("Why did you unmatch this person?"),
          Icon(Icons.question_mark)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {  },
          child: Text("Boring"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Overly Sexual"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Too Fast"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Scammer"),
        ),
        TextButton(
          onPressed: () {  },
          child: Text("Ghosting"),
        ),
      ],


    );
  }
}
