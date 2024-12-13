import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'check_box_event.dart';
part 'check_box_state.dart';

@injectable
class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  bool checkboxValue = false;

  CheckBoxBloc() : super(CheckBoxInitial()) {
    on<ToggleCheckbox>(_toggleCheckbox);
  }

  FutureOr<void> _toggleCheckbox(
    ToggleCheckbox event,
    Emitter<CheckBoxState> emit,
  ) {
    checkboxValue = event.checkBoxValue;

    emit(AuthToggleTermsPolicyState(checkBoxState: checkboxValue));
  }
}
