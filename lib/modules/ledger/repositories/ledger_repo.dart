import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/models/ledger_model.dart';
import 'package:sigma/services/database_service.dart';

class LedgerRepo {
  final _dbService = Modular.get<DatabaseService>();
  Future<void> addLedger({
    required final String ledgerName,
    required final String ledgerDescription,
  }) async {
    try {
      await _dbService.addLedger(
          ledger: LedgerModel(
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
}
