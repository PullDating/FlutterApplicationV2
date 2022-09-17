import 'package:flutter/material.dart';
import 'package:pull/models/person.dart';

//todo finish this widget and implement in the application.

class PullSwipeCard extends StatelessWidget {
  PullSwipeCard({
    Key? key,
    editOnly,
    required this.person,
  }) : super(key: key);

  Person person;

  ///true if in edit mode, false if in swiping mode (default is [False]) Controls
  ///if the user can see like buttons and interact with elements.
  bool editOnly = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //print(constraints.maxHeight);
        //print(constraints.maxWidth);
        return SizedBox(
          height: constraints.maxHeight*0.80,
          width: constraints.maxWidth*0.80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(person.uuid),
                    Text(person.name),
                    Text((person.biography != null)? person.biography! : " "),
                    Image.file(person.images[0]!)
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
