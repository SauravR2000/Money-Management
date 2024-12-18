import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/features/pincode/cubit/pincode_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/utils/constants/enums.dart';

@RoutePage()
class PinCodeWidget extends StatefulWidget {
  final String screenTitle;
  final Destination destination;
  const PinCodeWidget(
      {super.key, required this.screenTitle, required this.destination});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String enteredPin = '';
  bool isPinVisible = false;

  late PincodeCubit _pincodeCubit;
  late SecureLocalStorage storage;
  late String userToken;
  late String storedPinCode;

  @override
  void initState() {
    super.initState();
    _pincodeCubit = getIt<PincodeCubit>();
    storage = getIt<SecureLocalStorage>();
    getUserTokenAndPincode();
  }

  getUserTokenAndPincode() async {
    userToken = await storage.getStringValue(key: storage.token);
    storedPinCode = await storage.getStringValue(key: storage.pinCode);
  }

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextButton(
        onPressed: () {
          _pincodeCubit.pincodeNumber(number, widget.destination);
        },
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 38,
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 58),
              child: Center(
                child: Text(
                  widget.screenTitle,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 50),

            /// Pin code area
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4, // Number of PIN digits
                (index) {
                  return BlocBuilder<PincodeCubit, PincodeState>(
                    bloc: _pincodeCubit,
                    builder: (context, state) {
                      log("rebuild");

                      switch (widget.destination) {
                        case Destination.confirmPincode:
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 30, // Set a fixed width for circular design
                            height: 30, // Match height to make it circular
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20), // Circular shape
                              color: index < _pincodeCubit.pincodeString.length
                                  ? Colors
                                      .white // Filled color for entered digit
                                  : Colors
                                      .transparent, // Background for empty field
                              border: Border.all(
                                color: Colors.white
                                    .withValues(alpha: 0.5), // Border color
                                width: 3.5, // Border thickness
                              ),
                            ),
                            // No text displayed inside the container
                          );
                        case Destination.dashboard:
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 30, // Set a fixed width for circular design
                            height: 30, // Match height to make it circular
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20), // Circular shape
                              color: index <
                                      _pincodeCubit.confirmPincodeString.length
                                  ? Colors
                                      .white // Filled color for entered digit
                                  : Colors
                                      .transparent, // Background for empty field

                              border: Border.all(
                                color: Colors.white
                                    .withValues(alpha: 0.5), // Border color
                                width: 3.5, // Border thickness
                              ),
                            ),
                            // No text displayed inside the container
                          );
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 100.0),

            /// Digits
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => numButton(1 + 3 * i + index),
                  ).toList(),
                ),
              ),

            /// 0 digit with back remove
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: BlocBuilder<PincodeCubit, PincodeState>(
                      bloc: _pincodeCubit,
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            _pincodeCubit.pincodeBackspace(widget.destination);
                          },
                          child: const Icon(
                            Icons.backspace,
                            color: Colors.white,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                  numButton(0),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: TextButton(
                      onPressed: () {
                        log("stored passkey = $storedPinCode entered pin = ${_pincodeCubit.confirmPincodeString}");

                        switch (widget.destination) {
                          case Destination.confirmPincode:
                            if (_pincodeCubit.pincodeString == storedPinCode &&
                                userToken.isNotEmpty) {
                              log('Navigate to dashboard');

                              context.router.replaceAll([DashboardRoute()]);
                              _pincodeCubit.clearAllPincode(widget.destination);
                            } else if (storedPinCode.isEmpty &&
                                userToken.isNotEmpty) {
                              // _pincodeCubit.clearAllPincode(widget.destination);
                              context.router.push(ConfirmPincodeRoute());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 600),
                                  content: Text(
                                    "Invalid Pincode",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            break;
                          case Destination.dashboard:
                            if (_pincodeCubit.pincode ==
                                _pincodeCubit.confirmPincodeString) {
                              context.router.replaceAll([DashboardRoute()]);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 600),
                                  content: Text(
                                    "Invalid Pincode. Please try again.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            break;
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
