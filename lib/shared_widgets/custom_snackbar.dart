import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customErrorSnackBar({
  required BuildContext context,
  required String errorMessage,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    customSuccessSnackBar({
  required BuildContext context,
  required String errorMessage,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.green,
    ),
  );
}
