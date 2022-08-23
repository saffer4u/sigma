import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/models/ledger_model.dart';
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
      await ledgerCollection.add(ledger.toJson());
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
                print(doc.data());
                log("Get ledger list called");
                return LedgerModel.fromJson(
                  doc.data(),
                );
              }).toList(),
            );

    return ledgers;
  }
}
