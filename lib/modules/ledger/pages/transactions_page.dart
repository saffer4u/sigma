// ignore_for_file: unnecessary_const

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/modules/ledger/ledger_module.dart';
import 'package:sigma/widgets/loader.dart';

import '../../../theme/color_scheme.dart';
import '../../../utils/helpers.dart';
import '../cubit/ledger_dashboard_cubit.dart';
import '../cubit/transections_cubit.dart';

class TransactionsPage extends StatefulWidget {
  final String ledgerId;

  const TransactionsPage({Key? key, required this.ledgerId}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final _bloc = Modular.get<TransectionsCubit>();

  final _ledgerListBloc = Modular.get<LedgerListCubit>();
  final transactionNameController = TextEditingController();
  final transactionAmountController = TextEditingController();

  @override
  void initState() {
    _bloc.getTransactions(ledId: widget.ledgerId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _ledgerListBloc.getList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: WillPopScope(
        onWillPop: () async {
          // Modular.to.pushReplacementNamed(
          //     LedgerModuleRoutes.getRoute(LedgerModuleRoutes.ladgerHome));

          log("Transactions list Popped");

          return true;
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Transactions")),
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
                        controller: transactionNameController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                            labelText: "Transaction Name"),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: transactionAmountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Transaction Amount"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          Modular.to.pop();

                          await _bloc.addTransaction(
                              name: transactionNameController.text,
                              amount: double.parse(
                                  transactionAmountController.text));

                          transactionAmountController.clear();
                          transactionNameController.clear();
                        },
                        child: const Text("Add Transaction"),
                      )
                    ],
                  ),
                ),
              );
            },
            label: const Text("New Transaction"),
            icon: const Icon(Icons.add),
          ),
          body: BlocBuilder<TransectionsCubit, TransectionsState>(
            builder: (context, state) {
              if (state is TransactionLoadingState) {
                return const Loader(isLoading: true, child: SizedBox());
              } else if (state is TransactionErrorState) {
                return Center(
                  child: Text("Error : ${state.errMsg}"),
                );
              } else if (state is TansactionEmptyState) {
                return const Center(
                  child: Text("No Transactions found"),
                );
              } else if (state is TransactionSuccessState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Total Amount : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              state.totalAmount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: SigmaColorScheme.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.transcations.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Modular.to.pop();
                                          _bloc.deleteTransacation(
                                              transactionId: state
                                                  .transcations[index].id!);
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Modular.to.pop();
                                          },
                                          child: const Text("No")),
                                    ],
                                    title: Text("Delete"),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 0, 0, 0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    color: SigmaColorScheme.shadowColor,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.transcations[index].name!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "ID : ${state.transcations[index].id}",
                                          style: const TextStyle(
                                            color:
                                                SigmaColorScheme.secondaryColor,
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          "Created On : ${DateFormat('dd/MM/yyyy | hh:mm').format(state.transcations[index].time!)}",
                                          style: TextStyle(
                                            color: SigmaColorScheme
                                                .secondaryColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "₹ ${state.transcations[index].amount}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: SigmaColorScheme.primaryColor,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const Center(
                child: Text("Something went wrong"),
              );
            },
          ),
        ),
      ),
    );
  }
}
