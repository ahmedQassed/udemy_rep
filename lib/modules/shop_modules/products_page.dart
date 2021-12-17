import 'dart:developer';

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_categories_model.dart';
import 'package:im/models/shop_models/shop_home_model.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/shared/component/componant.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is SuccessFavState) {
          if (!state.model.status) {
            ShowToast(text: state.model.message, c: messageColor.ERROR);
          }
        }
      },
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.home != null && cubit.categoriesModel != null,
            builder: (context) => homeSlider(cubit.home, context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget homeSlider(ShopHomeModel? model, context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.ban
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  reverse: false,
                  height: 250.0,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                )),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.blueGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 100.0,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => i(ShopCubit.get(context)
                        .categoriesModel!
                        .data
                        .details[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 10.0,
                        ),
                    itemCount: ShopCubit.get(context)
                        .categoriesModel!
                        .data
                        .details
                        .length),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'New Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.blueGrey),
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.79,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    model.data.pro.length,
                    (index) => Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          model.data.pro[index].image),
                                      height: 200.0,
                                      width: double.infinity,
                                    ),
                                    if (model.data.pro[index].discount > 0)
                                      Container(
                                        color: Colors.amber,
                                        child: const Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Text(
                                              'sale',
                                              style: TextStyle(fontSize: 12.0),
                                            )),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  model.data.pro[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // const SizedBox(
                                //   height: 20.0,
                                // ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.green,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${model.data.pro[index].price.round()} L.E',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      if (model.data.pro[index].discount > 0)
                                        Text(
                                          '${model.data.pro[index].oldPrice.round()} L.E',
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                          ),
                                        ),
                                      const Spacer(),
                                      CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor:
                                            (ShopCubit.get(context).favorites[
                                                    ShopCubit.get(context)
                                                        .home!
                                                        .data
                                                        .pro[index]
                                                        .id])!
                                                ? Colors.blue
                                                : Colors.grey,
                                        child: IconButton(
                                            onPressed: () {
                                              ShopCubit.get(context).changeFav(
                                                  model.data.pro[index].id);
                                            },
                                            icon: const Icon(
                                              Icons.favorite_border,
                                              size: 15.0,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),
      );
}

Widget i(DataDetails model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
        ),
        Container(
          width: 100.0,
          color: Colors.black54.withOpacity(.3),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
