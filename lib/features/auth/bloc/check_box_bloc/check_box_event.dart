part of 'check_box_bloc.dart';

@immutable
sealed class CheckBoxEvent {}

class ToggleCheckbox extends CheckBoxEvent {
  final bool checkBoxValue;

  ToggleCheckbox({required this.checkBoxValue});
}
