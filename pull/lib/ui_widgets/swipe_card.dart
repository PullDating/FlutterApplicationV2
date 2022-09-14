import 'package:flutter/material.dart';

//todo finish this widget and implement in the application.

class PullSwipeCard extends StatelessWidget {
  PullSwipeCard({
    Key? key,
    editOnly,
  }) : super(key: key);



  ///true if in edit mode, false if in swiping mode (default is [False]) Controls
  ///if the user can see like buttons and interact with elements.
  bool editOnly = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: constraints.maxHeight * 0.92,
            width: constraints.maxWidth * 0.92,
          ),
        );
      }
    );
  }
}
