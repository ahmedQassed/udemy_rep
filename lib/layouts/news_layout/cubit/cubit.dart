import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/layouts/news_layout/cubit/states.dart';
import 'package:im/modules/news_modules/business_page.dart';
import 'package:im/modules/news_modules/science_page.dart';
import 'package:im/modules/news_modules/search.dart';
import 'package:im/modules/news_modules/sports_page.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    BusinessPage(),
    SportsPage(),
    SciencePage(),
  ];

  int currentIndex = 0;

  void BottomNav({required int index}) {
    currentIndex = index;
    if (index == 1) {
      getSportsData();
    }
    if (index == 2) {
      getScienceData();
    }

    emit(BottomNavState());
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center_sharp), label: 'Business'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_basketball),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusinessData() {
    emit(LoadingBusinessState());

    if (business.length == 0) {
      DioHelper.getDate(urlMethod: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'fb00511404b048479401173fd3b220e9',
      }).then((value) {
        business = value.data['articles'];
        print(business);

        emit(GetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(GetBusinessErrorState(error.toString()));
      });
    } else {
      emit(GetBusinessSuccessState());
    }
  }

  void getSportsData() {
    if (sports.length == 0) {
      DioHelper.getDate(urlMethod: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'fb00511404b048479401173fd3b220e9',
      }).then((value) {
        sports = value.data['articles'];
        print(sports);

        emit(GetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());

        emit(GetSportsErrorState(onError.toString()));
      });
    } else {
      emit(GetSportsSuccessState());
    }
  }

  void getScienceData() {
    if (science.length == 0) {
      DioHelper.getDate(urlMethod: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'fb00511404b048479401173fd3b220e9',
      }).then((value) {
        science = value.data['articles'];
        print(science);

        emit(GetSciencesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(GetScienceErrorState(onError.toString()));
      });
    } else {
      emit(GetSciencesSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String v) {
    DioHelper.getDate(urlMethod: 'v2/everything', query: {
      'q': v,
      'apiKey': 'fb00511404b048479401173fd3b220e9',
    }).then((value) {
      search = value.data['articles'];
      print(search.toString());

      emit(GetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetSearchErrorState(onError.toString()));
    });
  }
}
