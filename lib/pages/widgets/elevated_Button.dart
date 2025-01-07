import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String myText;
  final Color myColor;
  final VoidCallback onPressed;

  const MyElevatedButton({
    super.key,
    required this.myText,
    required this.myColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: myColor),
      child: Text(
        myText,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
