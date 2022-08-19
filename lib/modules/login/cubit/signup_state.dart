part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class Loading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFaild extends SignupState {
  final String message;
  const SignupFaild({required this.message});
}
