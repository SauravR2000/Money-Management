import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  const PinNumber({
    super.key,
    required this.textEditingController,
    required this.outlineInputBorder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // Smaller width for compact design
      height: 40, // Add a fixed height to make it circular
      child: TextField(
        controller: textEditingController,
        enabled: false, // Keep it disabled for now
        obscureText: true, // Hides the input text
        textAlign: TextAlign.center, // Center-align the text
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8), // Smaller padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), // Circular border
            borderSide: const BorderSide(
              color: Colors.purple, // Purple border color
              width: 1.5, // Thinner border width
            ),
          ),
          filled: true,
          fillColor: textEditingController.text.isNotEmpty
              ? Colors.white
              : Colors.white30, // Light semi-transparent background
        ),
        // style: GoogleFonts.aBeeZee(
        //   fontWeight: FontWeight.bold,
        //   fontSize: 16, // Slightly smaller font size
        //   color: Colors.white, // Text color
        // ),
      ),
    );
  }
}
