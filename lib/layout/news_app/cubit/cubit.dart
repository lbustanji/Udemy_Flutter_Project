import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/layout/news_app/cubit/states.dart';
import 'package:udimy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udimy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udimy_flutter/modules/news_app/sports/sports_screen.dart';
import 'package:udimy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  int businessSelectedItem = 0;
  bool isDesktop = false;
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void setDesktop(bool value) {
    isDesktop = value;
    emit(NewsSetDesktopState());
  }

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'e18088e563ee4896ba55410b7ede793d',
    })!
        .then((value) {
      business = value.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  void selectBusinessItem(index) {
    businessSelectedItem = index;

    emit(NewsSelectBusinessItemState());
  }

  void getSports() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sport',
      'apiKey': 'e18088e563ee4896ba55410b7ede793d',
    })!
        .then((value) {
      sports = value.data['articles'];
      emit(NewsSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'e18088e563ee4896ba55410b7ede793d',
    })!
        .then((value) {
      science = value.data['articles'];
      emit(NewsScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsScienceErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'e18088e563ee4896ba55410b7ede793d',
    })!
        .then((value) {
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
