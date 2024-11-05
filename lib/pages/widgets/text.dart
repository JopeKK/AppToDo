import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String mytext;
  final double size;

  const MyText({
    super.key,
    required this.mytext,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      mytext,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: size,
      ),
    );
  }
}
