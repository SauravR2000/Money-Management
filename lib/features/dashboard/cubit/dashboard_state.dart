part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DasboardPageChangedState extends DashboardState {
  final int index;
  DasboardPageChangedState({required this.index});
}
