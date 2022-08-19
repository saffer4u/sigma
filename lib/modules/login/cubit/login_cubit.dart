import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/services/firebase_auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuthService _authService = Modular.get<FirebaseAuthService>();
  LoginCubit() : super(LoginInitial());

  void getUser() async {
    emit(LoginLoadingState());

    User? user = await _authService.getCurrentUser().first;
    if (user == null) {
      emit(LoginInitial());
    } else {
      emit(LoginSuccessState());
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await _authService.login(email: email, password: password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFaildState(message: e.toString()));
    }
  }

  void logOut() async {
    emit(LoginLoadingState());
    try {
      await _authService.logOut();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFaildState(message: e.toString()));
    }
  }
}
