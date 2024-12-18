import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  int selectedIndex = 0;

  void changePage(int index) {
    selectedIndex = index;
    emit(DasboardPageChangedState(index: selectedIndex));
  }
}
