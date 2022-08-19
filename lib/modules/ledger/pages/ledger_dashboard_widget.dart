import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class LedgerDashboardWidget extends StatefulWidget {
  const LedgerDashboardWidget({Key? key}) : super(key: key);

  @override
  State<LedgerDashboardWidget> createState() => _LedgerDashboardWidgetState();
}

class _LedgerDashboardWidgetState extends State<LedgerDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Ledger Dashboard"),
    );
  }
}
