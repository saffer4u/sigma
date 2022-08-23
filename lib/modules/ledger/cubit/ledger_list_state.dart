part of 'ledger_list_cubit.dart';

abstract class LedgerListState extends Equatable {
  const LedgerListState();

  @override
  List<Object> get props => [];
}

class LedgerListInitial extends LedgerListState {}

class LedgerListLoading extends LedgerListState {}

class LedgerListLoaded extends LedgerListState {
  final List<LedgerModel> ledgerList;
  final int totalLedgers;

  const LedgerListLoaded(
      {required this.ledgerList, required this.totalLedgers});
}

class LedgerListEmpty extends LedgerListState {}

class LedgerListError extends LedgerListState {
  final String errorMsg;
  const LedgerListError({required this.errorMsg});
}
