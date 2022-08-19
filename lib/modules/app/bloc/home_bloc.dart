import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sigma/modules/app/bloc/home_states.dart';

import '../../../services/firebase_auth_service.dart';

class HomeBloc extends Cubit<HomeState> {
  final FirebaseAuthService _authService = Modular.get<FirebaseAuthService>();
  HomeBloc() : super(HomeInitialState());

  void checkUserState() async {
    emit(LoadingState());

    _authService.getCurrentUser().listen((user) {
      if (user == null) {
        emit(UserLoggedOutState());
      } else {
        emit(UserLoggedInState());
      }
    });
  }
}
