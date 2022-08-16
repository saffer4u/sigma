import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma/modules/app/bloc/home_states.dart';
import 'package:sigma/modules/todo_hive/services/hive_authentication.dart';
import 'package:sigma/modules/todo_hive/services/hive_todo.dart';

part 'hive_home_event.dart';
part 'hive_home_state.dart';

class HiveHomeBloc extends Bloc<HiveHomeEvent, HiveHomeState> {
  final HiveAuthenticationService _auth;
  final HiveTodoService _todo;
  HiveHomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emitter) async {
      final user = await _auth.authenticateUser(
        userName: event.userName,
        password: event.password,
      );
      if (user != null) {
        emit(HiveSuccessfulLoginState(userName: user));
        emit(const HiveHomeInitial());
      }
    });

    on<RegisterServiceEvent>(
      (event, emit) async {
        await _auth.init();
        await _todo.init();
        emit(HiveHomeInitial());
      },
    );
  }
}
