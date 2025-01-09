import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

void showFlutterToast({
  required String message,
  required bool isError,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
