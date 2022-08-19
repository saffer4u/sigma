part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFaildState extends LoginState {
  final String message;
  const LoginFaildState({required this.message});
}

class LoginSuccessState extends LoginState {}
