part of 'drop_down_cubit_cubit.dart';

@immutable
sealed class DropDownState {}

final class DropDownCubitInitial extends DropDownState {}

final class UpdateSelectedValueState extends DropDownState {
  final String? selectedValue;

  UpdateSelectedValueState({required this.selectedValue});
}
