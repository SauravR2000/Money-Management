import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pincode_state.dart';

class PincodeCubit extends Cubit<PincodeState> {
  PincodeCubit() : super(PincodeInitial());
}
