import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/models/ledger_model.dart';
import 'package:sigma/modules/ledger/models/transaction_model.dart';
import 'package:sigma/services/firebase_auth_service.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final authService = Modular.get<FirebaseAuthService>();

  Future<void> addLedger({required LedgerModel ledger}) async {
    final ledgerCollection = _db
        .collection("users_data")
        .doc(authService.getUid)
        .collection("ledgers");

    try {
      await ledgerCollection.doc(ledger.ledgerId).set(ledger.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<LedgerModel>> getLedgers() {
    final ledgerCollection = _db
        .collection("users_data")
        .doc(authService.getUid)
        .collection("ledgers");

    var ledgers =
        ledgerCollection.orderBy('editTime', descending: true).snapshots().map(
              (snapshot) => snapshot.docs.map((doc) {
                return LedgerModel.fromJson(
                  doc.data(),
                );
              }).toList(),
            );

    return ledgers;
  }

  Future<String?> getLedgerId() async {
    var randomId = math.Random().nextInt(10000).toString();

    bool docExist = await collectionExistCheck(
        collectionRef: _db
            .collection("users_data")
            .doc(authService.getUid)
            .collection("ledgers"),
        docId: randomId);

    if (!docExist) {
      return "LD-$randomId";
    } else {
      return null;
    }
  }

  Future<bool> collectionExistCheck({
    required CollectionReference collectionRef,
    required String docId,
  }) async {
    try {
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTransaction({
    required String ledgerId,
    required TransactionModel transaction,
  }) async {
    final transactionledgerCollection = _db
        .collection("users_data")
        .doc(authService.getUid)
        .collection("ledgers")
        .doc(ledgerId)
        .collection("transactions");

    try {
      // await ledgerCollection.doc(ledger.ledgerId).set(ledger.toJson());

      var docRef = await transactionledgerCollection.add(transaction.toJson());

      await transactionledgerCollection
          .doc(docRef.id)
          .update({"id": docRef.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<double> getTotalLedger({required final ledgerId}) async {
    double totalAmount = 0;
    List<TransactionModel> transactions =
        await getTransactions(ledgerId: ledgerId).first;

    for (var transaction in transactions) {
      totalAmount += transaction.amount!;
    }
    return totalAmount;
  }

  Stream<List<TransactionModel>> getTransactions(
      {required final String ledgerId}) {
    final transactionledgerCollection = _db
        .collection("users_data")
        .doc(authService.getUid)
        .collection("ledgers")
        .doc(ledgerId)
        .collection("transactions");

    var transactions = transactionledgerCollection
        .orderBy('time', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return TransactionModel.fromJson(
              doc.data(),
            );
          }).toList(),
        );

    return transactions;
  }

  Future<double> getTotalAmountToPay() async {
    double totalAmout = 0;
    var allLedgers = await getLedgers().first;

    for (var ledger in allLedgers) {
      var transactions =
          await getTransactions(ledgerId: ledger.ledgerId!).first;

      for (var transaction in transactions) {
        totalAmout += transaction.amount!;
      }
    }

    return totalAmout;
  }

  Future<void> deleteDoc(
      {required final String collectionPath,
      required final String docId}) async {
    try {
      log(collectionPath);
      await _db.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
