import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_search_model.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/shared/component/componant.dart';

import 'favorites_page.dart';

class ShopSearchPage extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultField(
                    onSub: () {
                      cubit.getSearch(searchController.text);
                    },
                    Controller: searchController,
                    type: TextInputType.text,
                    vale: (value) {
                      if (value!.isEmpty) {
                        return 'enter the word';
                      }
                    },
                    lbName: 'Search',
                    pre: Icons.search),
                const SizedBox(
                  height: 20.0,
                ),
                if (state is LoadingSearch) const LinearProgressIndicator(),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.m != null,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            favoritesItem(cubit.m, index, context),
                        separatorBuilder: (context, index) => MyDivider(),
                        itemCount: cubit.m!.data!.dataa.length),
                    fallback: (context) => Container(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget favoritesItem(ShopSearchModel? model, int index, context) => Padding(
    padding: EdgeInsets.all(10.0),
    child: Container(
      height: 120.0,
      width: double.infinity,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model!.data!.dataa[index].image}'),
                height: 120.0,
                width: 120.0,
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.data!.dataa[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(),
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '${model.data!.dataa[index].price.toString()} L.E',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
