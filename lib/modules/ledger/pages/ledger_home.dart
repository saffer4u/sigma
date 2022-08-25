import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_dashboard_cubit.dart';
import 'package:sigma/modules/ledger/cubit/ledger_home_cubit.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/modules/ledger/pages/ledger_dashboard_widget.dart';
import 'package:sigma/modules/ledger/pages/ledger_list_widget.dart';
import 'package:sigma/modules/login/login_module.dart';
import 'package:sigma/theme/color_scheme.dart';
import 'package:sigma/utils/helpers.dart';
import 'package:sigma/widgets/loader.dart';

class LedgerHome extends StatefulWidget {
  const LedgerHome({Key? key}) : super(key: key);

  @override
  State<LedgerHome> createState() => _LedgerHomeState();
}

class _LedgerHomeState extends State<LedgerHome>
    with SingleTickerProviderStateMixin {
  final _bloc = Modular.get<LedgerHomeCubit>();
  final _blocDasboard = Modular.get<LedgerDashboardCubit>();
  final _blocList = Modular.get<LedgerListCubit>();
  final ledgerNameController = TextEditingController();
  final ledgerDescriptionController = TextEditingController();

  @override
  void initState() {
    _blocList.getList();
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<LedgerHomeCubit, LedgerHomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ledger"),
              elevation: 0,
            ),
            body: Loader(
              isLoading: state is Loading,
              child: DefaultTabController(
                length: 2,
                child: Builder(builder: (context) {
                  final TabController tabController =
                      DefaultTabController.of(context)!;
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {}
                  });
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: SigmaColorScheme.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: SigmaColorScheme.shadowColor,
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints.expand(height: 60),
                        child: TabBar(
                          controller: tabController,
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.dashboard),
                            ),
                            Tab(
                              icon: Icon(Icons.list),
                            ),
                          ],
                          indicatorColor: SigmaColorScheme.secondaryColor,
                          indicatorWeight: 3,
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            LedgerDashboardWidget(),
                            LedgerListWidget(),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: SigmaColorScheme.primaryColor.withOpacity(0.7),
              onPressed: () {
                Alerts.showBottomSheet(
                  context,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: ledgerNameController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration:
                              const InputDecoration(labelText: "Ledger Name"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: ledgerDescriptionController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              labelText: "Ledger Description ( Optional )"),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            Modular.to.pop();

                            await _blocDasboard.addLedger(
                              ledgerDescription:
                                  ledgerDescriptionController.text,
                              ledgerName: ledgerNameController.text,
                            );

                            await _blocList.getList();
                            ledgerNameController.clear();
                          },
                          child: const Text("Add Ledger"),
                        )
                      ],
                    ),
                  ),
                );
              },
              label: const Text("New Ledger"),
              icon: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
