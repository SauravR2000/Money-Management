import 'package:flutter/material.dart';

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;

  const KeyboardNumber({
    super.key,
    required this.n,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 90,
        child: Text(
          '$n',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
