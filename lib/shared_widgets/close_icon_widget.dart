import 'package:flutter/material.dart';

class CloseIconWidget extends StatelessWidget {
  const CloseIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // Semi-transparent black color
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
