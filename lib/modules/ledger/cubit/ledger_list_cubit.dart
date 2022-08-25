import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/models/ledger_model.dart';
import 'package:sigma/modules/ledger/repositories/ledger_repo.dart';

part 'ledger_list_state.dart';

class LedgerListCubit extends Cubit<LedgerListState> {
  final repo = Modular.get<LedgerRepo>();
  LedgerListCubit() : super(LedgerListInitial());

  Future<void> deleteLedger({required final String ledgerId}) async {
    emit(LedgerListLoading());

    log(ledgerId);
    await repo.deleteLedger(ledgerId: ledgerId);

    await getList();
  }

  Future<void> getList() async {
    emit(LedgerListLoading());
    // await Future.delayed(const Duration(seconds: 3));
    try {
      List<LedgerModel> ledgerList = await repo.getLedgers().first;
      if (ledgerList.isEmpty) {
        emit(LedgerListEmpty());
      } else {
        for (var ledger in ledgerList) {
          var totalAmount =
              await repo.getTotalLedgerAmount(ledgerId: ledger.ledgerId!);

          ledger.totalAmount = totalAmount;
        }

        emit(LedgerListLoaded(
            ledgerList: ledgerList, totalLedgers: ledgerList.length));
      }

      // repo.getLedgers().listen((ledgerList) {
      //   if (ledgerList.isEmpty) {
      //     emit(LedgerListEmpty());
      //   } else {
      //     emit(LedgerListLoaded(ledgerList: ledgerList));
      //   }
      // });
    } catch (e) {
      emit(LedgerListError(errorMsg: e.toString()));
    }
  }
}
