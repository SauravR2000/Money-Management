import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'drop_down_cubit_state.dart';

@injectable
class DropDownCubit extends Cubit<DropDownState> {
  String? value;

  DropDownCubit() : super(DropDownCubitInitial());

  void changeSelectedValue({required String? selectedValue}) {
    value = selectedValue;

    emit(UpdateSelectedValueState(selectedValue: value));
  }
}
