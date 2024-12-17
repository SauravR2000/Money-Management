import 'package:flutter/material.dart';

class BorderlessTextField extends StatelessWidget {
  final TextEditingController controller;
  const BorderlessTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: false,
      maxLines: 1, // Restrict to 1 line
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: InputBorder.none, // Remove border
        enabledBorder: InputBorder.none, // Remove enabled border
        focusedBorder: InputBorder.none, // Remove focused border
        contentPadding: EdgeInsets.zero, // Remove extra padding
      ),
      style: TextStyle(
          fontSize: 64.0,
          color: Colors.white), // Optional: Customize text style
      textInputAction: TextInputAction.done, // Done action for keyboard
    );
  }
}
