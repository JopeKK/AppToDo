import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String myHintText;
  final Icon? suffixIcon;
  final ValueChanged onSubmitted;

  const MyTextField({
    super.key,
    required this.myHintText,
    required this.suffixIcon,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: myHintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        suffixIcon: suffixIcon ?? const Icon(Icons.add),
      ),
    );
  }
}
