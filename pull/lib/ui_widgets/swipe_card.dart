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

    //want to construct an interspersed display of the images and profile information
    //name should be overlayed over the whole profile
    //perhaps start with a photo
    //then show the biography if it exists
    //then the rest of the photos

    List<Widget> displayWidgets = [];
    //first photo in the display
    if(person.images.length >= 1){
      displayWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.file(person.images[0]!),
        ),
      ));
    }
    if(person.biography != null){
      displayWidgets.add(Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(person.biography!),
        ),
      ));
    }
    //add the rest of the images
    for(int i = 1; i < person.images.length; i++){
      displayWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), 
              child: Image.file(person.images[i]!)
            ),
          )
      );
    }


    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //print(constraints.maxHeight);
        //print(constraints.maxWidth);
        return SizedBox(
          height: constraints.maxHeight*0.80,
          width: constraints.maxWidth*0.80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1.00),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: const Offset(0,0),
                ),
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: ListView(
                      children: displayWidgets,
                    ),
                  ),
                  Row(
                    children: [
                      Text(person.uuid),
                      Text(person.name),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
