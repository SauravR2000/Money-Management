import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/pincode/ui/pin_code_widget.dart';
import 'package:money_management_app/utils/constants/enums.dart';

@RoutePage()
class ConfirmPincodeScreen extends StatelessWidget {
  const ConfirmPincodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeWidget(
        screenTitle: 'Ok. Re enter your PIN',
        destination: Destination.dashboard);
  }
}
