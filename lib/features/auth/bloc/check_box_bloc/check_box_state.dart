part of 'check_box_bloc.dart';

@immutable
sealed class CheckBoxState {}

final class CheckBoxInitial extends CheckBoxState {}

final class AuthToggleTermsPolicyState extends CheckBoxState {
  final bool checkBoxState;

  AuthToggleTermsPolicyState({required this.checkBoxState});
}
