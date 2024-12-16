part of 'pincode_cubit.dart';

@immutable
sealed class PincodeState {}

final class PincodeInitial extends PincodeState {}

final class PincodeNumberToStringState extends PincodeState {
  final String number;

  PincodeNumberToStringState({required this.number});
}

final class PincodeWhenBackspacePressedState extends PincodeState {
  final String enteredPincode;

  PincodeWhenBackspacePressedState({required this.enteredPincode});
}
