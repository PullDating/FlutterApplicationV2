import 'package:flutter/material.dart';

class PullToggleButton extends StatelessWidget {
  const PullToggleButton({
    Key? key,
    required this.onToggle,
    required this.text,
    required this.pressed,
  }) : super(key: key);
  //function that runs when the button is pressed.
  final Function() onToggle;
  ///the text shown on the toggle button
  final String text;
  //determines if the button is pressed or not, if true, it has been pressed, false otherwise.
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onToggle(),
      style: ElevatedButton.styleFrom(
        primary: (pressed)
            ? Colors.lightBlueAccent
            : Colors.grey,
      ),
      child: Text(text),
    );
  }
}

