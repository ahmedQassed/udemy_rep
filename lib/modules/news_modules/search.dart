import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/layouts/news_layout/cubit/cubit.dart';
import 'package:im/layouts/news_layout/cubit/states.dart';
import 'package:im/shared/component/componant.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context);
        var list = NewsAppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text('data'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey,
                )),
          ),
          body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: defaultField(
                      Controller: searchController,
                      type: TextInputType.text,
                      vale: (value) {
                        if (value!.isEmpty) {
                          return 'search must not be empty';
                        }
                      },
                      lbName: 'Search',
                      pre: Icons.search,
                      change: (value) {
                        cubit.getSearch(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: PageContent(list, s: false),
                  )
                ],
              )),
        );
      },
    );
  }
}
