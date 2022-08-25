import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ledger_home_state.dart';

class LedgerHomeCubit extends Cubit<LedgerHomeState> {
  // final _authService = Modular.get<FirebaseAuthService>();

  LedgerHomeCubit() : super(LedgerHomeInitial());

  // void getUserState() {
  //   _authService.getCurrentUser().listen((user) {
  //     emit(Loading());
  //     if (user == null) {
  //       emit(LedgerHomeSignOutState());
  //     } else {
  //       emit(LedgerHomeSignInState());
  //     }
  //   });
  // }
}
