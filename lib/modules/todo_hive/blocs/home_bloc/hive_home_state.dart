part of 'hive_home_bloc.dart';

abstract class HiveHomeState extends Equatable {
  const HiveHomeState();
}

class HiveHomeInitial extends HiveHomeState {
  const HiveHomeInitial();
  @override
  List<Object?> get props => [];
}

class HiveSuccessfulLoginState extends HiveHomeState {
  final String userName;

  const HiveSuccessfulLoginState({required this.userName});

  @override
  List<Object?> get props => [userName];
}

class RegisteringServicesState extends HiveHomeState {
  @override
  List<Object?> get props => [];
}
