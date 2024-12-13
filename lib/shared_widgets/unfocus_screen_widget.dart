import 'dart:developer';

import 'package:flutter/material.dart';

class UnfocusScreenWidget extends StatelessWidget {
  final Widget child;
  const UnfocusScreenWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          log("close keyboard");
          FocusScope.of(context).unfocus();
        },
        child: child,
      ),
    );
  }
}
