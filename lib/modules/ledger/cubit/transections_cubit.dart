import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_dashboard_cubit.dart';
import 'package:sigma/modules/ledger/models/transaction_model.dart';
import 'package:sigma/modules/ledger/repositories/ledger_repo.dart';

part 'transections_state.dart';

class TransectionsCubit extends Cubit<TransectionsState> {
  final _repo = Modular.get<LedgerRepo>();
  TransectionsCubit() : super(TransectionsInitial());

  late String ledgerId;

  Future<void> deleteTransacation({required String transactionId}) async {
    emit(TransactionLoadingState());
    await _repo.deleteTransaction(
        transactionId: transactionId, ledgerId: ledgerId);
    await getTransactions(ledId: ledgerId);
  }

  Future<void> getTransactions({required String ledId}) async {
    emit(TransactionLoadingState());
    ledgerId = ledId;

    try {
      List<TransactionModel> transactionsList =
          await _repo.getTransactions(ledgerId: ledgerId).first;

      if (transactionsList.isEmpty) {
        emit(TansactionEmptyState());
      } else {
        emit(TransactionSuccessState(
            transcations: transactionsList,
            totalAmount: getTotalAmount(transactions: transactionsList)));
      }
    } catch (e) {
      emit(TransactionErrorState(errMsg: e.toString()));
    }
  }

  double getTotalAmount({required List<TransactionModel> transactions}) {
    double totalAmount = 0;
    for (var element in transactions) {
      totalAmount += element.amount!;
    }
    return totalAmount;
  }

  Future<void> addTransaction({
    required String name,
    required double amount,
  }) async {
    await _repo.addTransaction(
      ledgerId: ledgerId,
      amount: amount,
      name: name,
    );

    await getTransactions(ledId: ledgerId);
  }
}
