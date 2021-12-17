import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/layouts/news_layout/cubit/cubit.dart';
import 'package:im/layouts/news_layout/cubit/states.dart';
import 'package:im/modules/news_modules/search.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsAppCubit cubit = NewsAppCubit.get(context);
        AppCubit modeCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News app',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchPage(),
                    );
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    modeCubit.appMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.BottomNav(index: index);
              },
              items: cubit.items),
        );
      },
    );
  }
}
