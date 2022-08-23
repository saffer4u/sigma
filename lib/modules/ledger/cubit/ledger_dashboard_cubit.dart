import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/modules/ledger/repositories/ledger_repo.dart';

import '../models/ledger_model.dart';

part 'ledger_dashboard_state.dart';

class LedgerDashboardCubit extends Cubit<LedgerDashboardState> {
  final _repo = Modular.get<LedgerRepo>();
  final repo = Modular.get<LedgerRepo>();
  LedgerDashboardCubit() : super(LedgerDashboardInitial());

  Future<void> getDashboardValues() async {
    List<LedgerModel> ledgerList = await repo.getLedgers().first;

    emit(LadgerDashBoardValuesState(ledgerCount: ledgerList.length));
  }

  Future<void> addLedger({
    required final String ledgerName,
    required final String ledgerDescription,
  }) async {
    emit(LedgerLoadingState());
    try {
      _repo.addLedger(
        ledgerName: ledgerName,
        ledgerDescription: ledgerDescription,
      );

      emit(LedgerAddedState());
      await getDashboardValues();
    } catch (e) {
      emit(LedgerErrorState(errMsg: e.toString()));
    }
  }
}
