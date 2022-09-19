import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnmatchDialogue extends StatelessWidget {
  const UnmatchDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Row(
        children: [
          Text("Why did you unmatch?")
        ],
      ),
      content: Column(
        children: [
          Text("This allows us to curate the pool of people better for you, and everyone else.")
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
          child: Text("Ghosting"),
        ),
      ],


    );
  }
}
