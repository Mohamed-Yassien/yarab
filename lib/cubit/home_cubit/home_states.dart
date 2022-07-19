abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBarChangeIndexState extends HomeStates {}

class HomeLoadingState extends HomeStates{}

class HomeGetDataSuccessState extends HomeStates{}

class HomeGetDataErrorState extends HomeStates{

  final String error;

  HomeGetDataErrorState(this.error);

}
