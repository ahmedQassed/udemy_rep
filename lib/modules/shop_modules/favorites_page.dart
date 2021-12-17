import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_categories_model.dart';
import 'package:im/models/shop_models/shop_fav_model.dart';
import 'package:im/models/shop_models/shop_get_fav_model.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/shared/component/componant.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: state is! LoadingGetFav && cubit.shopGetFavModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    favoritesItem(cubit.shopGetFavModel, index, context),
                separatorBuilder: (context, index) => MyDivider(),
                itemCount: cubit.shopGetFavModel!.data!.data.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget favoritesItem(ShopGetFavModel? model, int index, context) => Padding(
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
                image: NetworkImage(model!.data!.data[index].product!.image),
                height: 120.0,
                width: 120.0,
              ),
              if (model.data!.data[index].product!.discount != 0)
                Container(
                  color: Colors.amber,
                  child: const Text('sale'),
                )
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
                  model.data!.data[index].product!.name,
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
                          '${model.data!.data[index].product!.price.toString()} L.E',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.data!.data[index].product!.discount != 0)
                      Text(
                        model.data!.data[index].product!.oldPrice.toString(),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 18.0,
                      backgroundColor: (ShopCubit.get(context).favorites[
                              ShopCubit.get(context)
                                  .shopGetFavModel!
                                  .data!
                                  .data[index]
                                  .product!
                                  .id])!
                          ? Colors.deepPurple
                          : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFav(
                              ShopCubit.get(context)
                                  .shopGetFavModel!
                                  .data!
                                  .data[index]
                                  .product!
                                  .id);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        iconSize: 20.0,
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
