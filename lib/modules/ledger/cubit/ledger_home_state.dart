part of 'ledger_home_cubit.dart';

abstract class LedgerHomeState extends Equatable {
  const LedgerHomeState();

  @override
  List<Object> get props => [];
}

class LedgerHomeInitial extends LedgerHomeState {}

class Loading extends LedgerHomeState {}

class LedgerHomeSignOutState extends LedgerHomeState {}

class LedgerHomeSignInState extends LedgerHomeState {}
