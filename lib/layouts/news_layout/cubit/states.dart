abstract class NewsAppStates {}

class InitState extends NewsAppStates {}

class BottomNavState extends NewsAppStates {}

class GetBusinessSuccessState extends NewsAppStates {}

class GetBusinessErrorState extends NewsAppStates {
  String error;

  GetBusinessErrorState(this.error);
}

class LoadingBusinessState extends NewsAppStates {}

class GetSportsSuccessState extends NewsAppStates {}

class GetSportsErrorState extends NewsAppStates {
  String error;

  GetSportsErrorState(this.error);
}

class GetSciencesSuccessState extends NewsAppStates {}

class GetScienceErrorState extends NewsAppStates {
  String error;

  GetScienceErrorState(this.error);
}

class GetSearchSuccessState extends NewsAppStates {}

class GetSearchErrorState extends NewsAppStates {
  String error;

  GetSearchErrorState(this.error);
}
