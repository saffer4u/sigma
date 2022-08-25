part of 'transections_cubit.dart';

abstract class TransectionsState extends Equatable {
  const TransectionsState();

  @override
  List<Object> get props => [];
}

class TransectionsInitial extends TransectionsState {}

class TransactionLoadingState extends TransectionsState {}

class TransactionSuccessState extends TransectionsState {
  final List<TransactionModel> transcations;
  final double totalAmount;

  const TransactionSuccessState(
      {required this.transcations, required this.totalAmount});
}

class TransactionAddedState extends TransectionsState {}

class TansactionEmptyState extends TransectionsState {}

class TransactionErrorState extends TransectionsState {
  final String errMsg;
  const TransactionErrorState({required this.errMsg});
}
