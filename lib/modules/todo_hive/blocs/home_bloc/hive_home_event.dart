part of 'hive_home_bloc.dart';

abstract class HiveHomeEvent extends Equatable {
  const HiveHomeEvent();
}

class LoginEvent extends HiveHomeEvent {
  final String userName;
  final String password;

  const LoginEvent({
    required this.password,
    required this.userName,
  });
  @override
  List<Object?> get props => [userName, password];
}

class RegisterServiceEvent extends HiveHomeEvent {
  @override
  List<Object?> get props => [];
}
