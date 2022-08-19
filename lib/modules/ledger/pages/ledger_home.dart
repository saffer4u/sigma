import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/ledger/cubit/ledger_home_cubit.dart';
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

class _LedgerHomeState extends State<LedgerHome> {
  final _bloc = Modular.get<LedgerHomeCubit>();

  @override
  void initState() {
    _bloc.getUserState();
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ledger"),
          elevation: 0,
        ),
        body: BlocBuilder<LedgerHomeCubit, LedgerHomeState>(
          builder: (context, state) {
            if (state is LedgerHomeSignOutState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are not Logged In"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () => Modular.to.pushReplacementNamed(
                          LoginModuleRoute.getRoute(
                              LoginModuleRoute.loginHome)),
                      child: const Text("LogIn")),
                ],
              ));
            }

            return Loader(
              isLoading: state is Loading,
              child: DefaultTabController(
                length: 2,
                child: Column(
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
                      child: const TabBar(
                        tabs: [
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
                      child: TabBarView(children: [
                        LedgerDashboardWidget(),
                        LedgerListWidget(),
                      ]),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
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
                      textCapitalization: TextCapitalization.sentences,
                      decoration:
                          const InputDecoration(labelText: "Ledger Name"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Add Ledger"))
                  ],
                ),
              ),
            );
          },
          label: const Text("New Ledger"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
