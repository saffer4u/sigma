import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sigma/modules/ledger/cubit/ledger_list_cubit.dart';
import 'package:sigma/theme/color_scheme.dart';
import 'package:sigma/widgets/loader.dart';

class LedgerListWidget extends StatefulWidget {
  const LedgerListWidget({Key? key}) : super(key: key);

  @override
  State<LedgerListWidget> createState() => _LedgerListWidgetState();
}

class _LedgerListWidgetState extends State<LedgerListWidget> {
  final _bloc = Modular.get<LedgerListCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<LedgerListCubit, LedgerListState>(
        builder: (context, state) {
          if (state is LedgerListLoading) {
            return const Loader(isLoading: true, child: SizedBox());
          } else if (state is LedgerListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                itemCount: state.ledgerList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.ledgerList[index].name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        state.ledgerList[index].description.isNotEmpty
                            ? Text(
                                state.ledgerList[index].description,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                        Text(
                          "Created On : ${DateFormat('MM/yyyy').format(state.ledgerList[index].creationTime)}",
                          style: TextStyle(
                            color: SigmaColorScheme.secondaryColor
                                .withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "Last Edited : ${DateFormat('dd/MM/yyyy | hh:mm').format(state.ledgerList[index].creationTime)}",
                          style: TextStyle(
                            color: SigmaColorScheme.secondaryColor
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is LedgerListEmpty) {
            return const Center(
              child: Text("No ledgers found"),
            );
          } else if (state is LedgerListError) {
            return Center(
              child: Text("Error While Loading : ${state.errorMsg}"),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
