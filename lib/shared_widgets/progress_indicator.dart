import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double progress;

  const CustomProgressIndicator(
      {super.key,
      required this.height,
      required this.width,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: width * progress.abs(),
            height: height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 252, 172, 18),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
