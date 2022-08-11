import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma/modules/app/bloc/home_states.dart';

class HomeBloc extends Cubit<HomeInitialState> {
  HomeBloc() : super(HomeInitialState(counter: 0));

  void increaseCounter() {
    emit(HomeInitialState(counter: state.counter+1));
  }
}


