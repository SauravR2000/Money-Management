import 'package:flutter/material.dart';

Widget screenPadding({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: child,
  );
}
