import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ledger_dashboard_state.dart';

class LedgerDashboardCubit extends Cubit<LedgerDashboardState> {
  LedgerDashboardCubit() : super(LedgerDashboardInitial());
}
