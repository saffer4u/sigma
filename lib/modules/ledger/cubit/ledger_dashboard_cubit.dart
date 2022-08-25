import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/modules/ledger/repositories/ledger_repo.dart';

import '../models/ledger_model.dart';

part 'ledger_dashboard_state.dart';

class LedgerDashboardCubit extends Cubit<LedgerDashboardState> {
  final _repo = Modular.get<LedgerRepo>();

  LedgerDashboardCubit() : super(LedgerDashboardInitial());

  Future<void> updateDashBoard(
      LadgerDashBoardValuesState dashboardStateEmit) async {}

  Future<void> getDashboardValues() async {
    emit(LedgerLoadingState());
    int ledgerCount = 0;

    _repo.getLedgers().listen((ledgers) async {
      log("Listinger called");
      ledgerCount = ledgers.length;
      var totalAmount = await _repo.getTotalAmountToPay();

      emit(LadgerDashBoardValuesState(
        ledgerCount: ledgerCount,
        totalAmount: totalAmount,
      ));
    });
  }

  Future<void> addLedger({
    required final String ledgerName,
    required final String ledgerDescription,
  }) async {
    emit(LedgerLoadingState());
    try {
      await _repo.addLedger(
        ledgerName: ledgerName,
        ledgerDescription: ledgerDescription,
      );

      emit(LedgerAddedState());
      // await getDashboardValues();
    } catch (e) {
      emit(LedgerErrorState(errMsg: e.toString()));
    }
  }
}
