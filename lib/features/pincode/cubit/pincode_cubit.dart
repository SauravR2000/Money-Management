import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/features/pincode/ui/pin_code_widget.dart';

part 'pincode_state.dart';

@singleton
class PincodeCubit extends Cubit<PincodeState> {
  String pincodeString = '';
  String confirmPincodeString = '';

  PincodeCubit() : super(PincodeInitial());

  void pincodeNumber(int pincodeNumber, Destination destination) {
    log("called pin = $pincodeNumber  destination = $destination");
    switch (destination) {
      case Destination.conformPincode:
        pincodeString += pincodeNumber.toString();
        emit(PincodeNumberToStringState(number: pincodeString));
        break;
      case Destination.dashboard:
        confirmPincodeString += pincodeNumber.toString();
        emit(PincodeNumberToStringState(number: confirmPincodeString));
        break;
    }
  }

  void pincodeBackspace(Destination destination) {
    switch (destination) {
      case Destination.conformPincode:
        if (pincodeString.isNotEmpty) {
          pincodeString = pincodeString.substring(0, pincodeString.length - 1);
          emit(PincodeWhenBackspacePressedState(enteredPincode: pincodeString));
        }
        break;
      case Destination.dashboard:
        if (confirmPincodeString.isNotEmpty) {
          confirmPincodeString = confirmPincodeString.substring(
              0, confirmPincodeString.length - 1);
          emit(PincodeWhenBackspacePressedState(
              enteredPincode: confirmPincodeString));
        }
        break;
    }
  }
}
