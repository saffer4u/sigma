import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class LedgerListWidget extends StatefulWidget {
  const LedgerListWidget({Key? key}) : super(key: key);

  @override
  State<LedgerListWidget> createState() => _LedgerListWidgetState();
}

class _LedgerListWidgetState extends State<LedgerListWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Ledger List Widget"),
    );
  }
}
