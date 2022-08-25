import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/models/ledger_model.dart';
import 'package:sigma/modules/ledger/models/transaction_model.dart';
import 'package:sigma/services/database_service.dart';
import 'package:sigma/services/firebase_auth_service.dart';

class LedgerRepo {
  final _dbService = Modular.get<DatabaseService>();
  final _authService = Modular.get<FirebaseAuthService>();
  Future<void> addLedger({
    required final String ledgerName,
    required final String ledgerDescription,
  }) async {
    try {
      String? id = await _dbService.getLedgerId();
      await _dbService.addLedger(
          ledger: LedgerModel(
        ledgerId: id!,
        name: ledgerName,
        description: ledgerDescription,
        creationTime: DateTime.now(),
        editTime: DateTime.now(),
      ));
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<LedgerModel>> getLedgers() {
    return _dbService.getLedgers();
  }

  Future<double> getTotalAmountToPay() async {
    var totalAmount = await _dbService.getTotalAmountToPay();

    return totalAmount;
  }

  Future<double> getTotalLedgerAmount({required String ledgerId}) async {
    var totalAmount = await _dbService.getTotalLedger(ledgerId: ledgerId);
    return totalAmount;
  }

  Stream<List<TransactionModel>> getTransactions(
      {required final String ledgerId}) {
    return _dbService.getTransactions(ledgerId: ledgerId);
  }

  Future<void> deleteLedger({required final String ledgerId}) async {
    try {
      await _dbService.deleteDoc(
        collectionPath: "users_data/${_authService.getUid}/ledgers",
        docId: ledgerId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(
      {required String transactionId, required String ledgerId}) async {
    try {
      await _dbService.deleteDoc(
        collectionPath:
            "users_data/${_authService.getUid}/ledgers/$ledgerId/transactions",
        docId: transactionId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTransaction({
    required String ledgerId,
    required double amount,
    required String name,
  }) async {
    try {
      await _dbService.addTransaction(
        ledgerId: ledgerId,
        transaction: TransactionModel(
          amount: amount,
          name: name,
          time: DateTime.now(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
