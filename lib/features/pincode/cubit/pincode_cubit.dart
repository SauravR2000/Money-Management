import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/features/pincode/ui/pin_code_widget.dart';
import 'package:money_management_app/injection/injection_container.dart';

part 'pincode_state.dart';

@singleton
class PincodeCubit extends Cubit<PincodeState> {
  final storage = getIt<SecureLocalStorage>();

  String pincode = '';

  String pincodeString = '';
  String confirmPincodeString = '';

  PincodeCubit() : super(PincodeInitial());

  void pincodeNumber(int pincodeNumber, Destination destination) {
    log("called pin = $pincodeNumber  destination = $destination");
    switch (destination) {
      case Destination.confirmPincode:
        if (pincodeString.length < 4) {
          pincodeString += pincodeNumber.toString();
          pincode = pincodeString;
          emit(PincodeNumberToStringState(number: pincodeString));
          break;
        }

      case Destination.dashboard:
        if (confirmPincodeString.length < 4) {
          confirmPincodeString += pincodeNumber.toString();

          storage.storeStringValue(
            key: storage.pinCode,
            value: confirmPincodeString,
          );

          emit(PincodeNumberToStringState(number: confirmPincodeString));
          break;
        }
    }
  }

  void pincodeBackspace(Destination destination) {
    switch (destination) {
      case Destination.confirmPincode:
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

  void clearAllPincode(Destination destination) {
    switch (destination) {
      case Destination.confirmPincode:
        if (pincodeString.isNotEmpty) {
          pincodeString = pincodeString.substring(
              0, pincodeString.length - pincodeString.length);
          emit(PincodeWhenBackspacePressedState(enteredPincode: pincodeString));
        }
        break;
      case Destination.dashboard:
        if (confirmPincodeString.isNotEmpty) {
          confirmPincodeString = confirmPincodeString.substring(
              0, confirmPincodeString.length - confirmPincodeString.length);
          emit(PincodeWhenBackspacePressedState(
              enteredPincode: confirmPincodeString));
        }
        break;
    }
  }
}
