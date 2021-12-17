import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/layouts/news_layout/cubit/cubit.dart';
import 'package:im/layouts/news_layout/cubit/states.dart';
import 'package:im/shared/component/componant.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsAppCubit cubit = NewsAppCubit.get(context);
        return PageContent(cubit.sports);
      },
    );
  }
}
