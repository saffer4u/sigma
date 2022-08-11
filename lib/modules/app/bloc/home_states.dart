abstract class HomeState {
  HomeState();
}

class HomeInitialState extends HomeState {
  int counter;
  HomeInitialState({required this.counter});
}
