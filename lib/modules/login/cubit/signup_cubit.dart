import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/firebase_auth_service.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final FirebaseAuthService _authService = Modular.get<FirebaseAuthService>();
  SignupCubit() : super(SignupInitial());

  void signUp({required String email, required String password}) async {
    emit(Loading());
    try {
      await _authService.signUp(email: email, password: password);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFaild(message: e.toString()));
    }
  }
}
