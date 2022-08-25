import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/theme/color_scheme.dart';
import 'package:sigma/widgets/loader.dart';

import '../../../utils/helpers.dart';
import '../cubit/ledger_dashboard_cubit.dart';

class LedgerDashboardWidget extends StatefulWidget {
  const LedgerDashboardWidget({Key? key}) : super(key: key);

  @override
  State<LedgerDashboardWidget> createState() => _LedgerDashboardWidgetState();
}

class _LedgerDashboardWidgetState extends State<LedgerDashboardWidget> {
  final _bloc = Modular.get<LedgerDashboardCubit>();

  @override
  void initState() {
    _bloc.getDashboardValues();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<LedgerDashboardCubit, LedgerDashboardState>(
        listener: (context, state) {
          if (state is LedgerAddedState) {
            _showErrorMessage(message: "Ledger Added Successfully");
          }
        },
        builder: (context, state) {
          if (state is LadgerDashBoardValuesState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "DASHBOARD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: SigmaColorScheme.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SigmaColorScheme.primaryColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: SigmaColorScheme.shadowColor,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "TOTAL LEDGERS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.ledgerCount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                            color: SigmaColorScheme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "TOTAL Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "₹ ${state.totalAmount}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: SigmaColorScheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is LedgerLoadingState) {
            return const Loader(
              isLoading: true,
              child: SizedBox.shrink(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

void _showErrorMessage({
  required String message,
}) {
  Alerts.showSnackBar(message);
}
