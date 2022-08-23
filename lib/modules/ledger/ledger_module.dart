import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_dashboard_cubit.dart';
import 'package:sigma/modules/ledger/cubit/ledger_home_cubit.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/modules/ledger/pages/ledger_home.dart';
import 'package:sigma/modules/ledger/repositories/ledger_repo.dart';
import 'package:sigma/services/database_service.dart';

import '../../services/firebase_auth_service.dart';
import '../app/sigma_app_modules.dart';

class LedgerModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance((i) => FirebaseAuthService()),
        Bind.instance((i) => DatabaseService()),
        Bind((i) => LedgerHomeCubit(), isSingleton: true),
        Bind((i) => LedgerDashboardCubit(), isSingleton: true),
        Bind((i) => LedgerDashboardCubit(), isSingleton: true),
        Bind((i) => LedgerRepo(), isSingleton: true),
        Bind((i) => LedgerListCubit(), isSingleton: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          LedgerModuleRoutes.ladgerHome,
          child: (context, args) => const LedgerHome(),
        ),
      ];
}

abstract class LedgerModuleRoutes {
  static String ladgerHome = "/ladger_home";

  static String getRoute(String route) {
    return SigmaAppModuleRoute.ledgerModule + route;
  }
}
