import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/features/pincode/ui/keyboard_number.dart';
import 'package:money_management_app/features/pincode/ui/pin_number.dart';

@RoutePage()
class PincodeScreen extends StatefulWidget {
  const PincodeScreen({super.key});

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  int pinIndex = 0;

  List<String> currentPin = ["", "", "", ""];

  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            buildExitButton(),
            Expanded(
              child: Container(
                alignment: const Alignment(0, 0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildSecurityText(),
                    const SizedBox(height: 40),
                    buildPinRow(),
                    buildNumberPad(),
                  ],
                ),
              ),
            ),
            // buildNumberPad(),
          ],
        ),
      ),
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i < 4; i++)
                    KeyboardNumber(
                      n: i,
                      onPressed: () {
                        pinIndexSetup(i.toString());
                      },
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 4; i < 7; i++)
                    KeyboardNumber(
                      n: i,
                      onPressed: () {
                        pinIndexSetup(i.toString());
                      },
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 7; i < 10; i++)
                    KeyboardNumber(
                      n: i,
                      onPressed: () {
                        pinIndexSetup(i.toString());
                      },
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 60,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup('0');
                    },
                  ),
                  SizedBox(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: const Icon(
                        Icons.backspace_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 4) {
      pinIndex++;
    }

    setPin(pinIndex, text);

    currentPin[pinIndex - 1] = text;

    String strPin = "";

    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) {
      print(strPin);
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
      ],
    );
  }
}

/// Builds a [Text] widget displaying the security PIN label.
///
/// Returns a [Text] widget that can be used in the UI layout.
buildSecurityText() {
  return Text(
    'Security PIN',
    style: GoogleFonts.aBeeZee(
      fontSize: 21,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

/// Builds a MaterialButton that closes the PincodeScreen when pressed.
///
/// The button is a white circle with a black "X" icon. It is positioned at the
/// top-right corner of the screen.
///
/// Returns a [Widget] that can be used as a child of a [Stack] or any other
/// widget that can have children.
buildExitButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {},
          height: 50,
          minWidth: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
