abstract class HomeState {
  HomeState();
}

class HomeInitialState extends HomeState {}

class LoadingState extends HomeState {}

class UserLoggedInState extends HomeState {}

class UserLoggedOutState extends HomeState {}
