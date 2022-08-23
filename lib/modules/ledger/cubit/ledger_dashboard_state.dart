part of 'ledger_dashboard_cubit.dart';

abstract class LedgerDashboardState extends Equatable {
  const LedgerDashboardState();

  @override
  List<Object> get props => [];
}

class LedgerDashboardInitial extends LedgerDashboardState {}

class LedgerLoadingState extends LedgerDashboardState {}

class LedgerAddedState extends LedgerDashboardState {}

class LadgerDashBoardValuesState extends LedgerDashboardState {
  final int ledgerCount;
  const LadgerDashBoardValuesState({required this.ledgerCount});
}

class LedgerErrorState extends LedgerDashboardState {
  final String errMsg;

  const LedgerErrorState({required this.errMsg});
}
