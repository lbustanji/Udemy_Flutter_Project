abstract class NewsStates {}
class NewsInitialState extends NewsStates{}
class NewsBottomNavState extends NewsStates{}
class NewsBusinessSuccessState extends NewsStates{}
class NewsBusinessLoadingState extends NewsStates{}
class NewsBusinessErrorState extends NewsStates{
  final String error;
  NewsBusinessErrorState(this.error);
}
class NewsSelectBusinessItemState extends NewsStates{}
class NewsSportsSuccessState extends NewsStates{}
class NewsSportsLoadingState extends NewsStates{}
class NewsSportsErrorState extends NewsStates{
  final String error;
  NewsSportsErrorState(this.error);
}
class NewsScienceSuccessState extends NewsStates{}
class NewsScienceLoadingState extends NewsStates{}
class NewsScienceErrorState extends NewsStates{
  final String error;
  NewsScienceErrorState(this.error);
}

class NewsSearchSuccessState extends NewsStates{}
class NewsSearchLoadingState extends NewsStates{}
class NewsSearchErrorState extends NewsStates{
  final String error;
  NewsSearchErrorState(this.error);
}

class NewsSetDesktopState extends NewsStates{}