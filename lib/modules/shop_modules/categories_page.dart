import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_categories_model.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/shared/component/componant.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoriesItems(
              ShopCubit.get(context).categoriesModel!.data.details[index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount:
              ShopCubit.get(context).categoriesModel!.data.details.length,
        );
      },
    );
  }
}

Widget categoriesItems(DataDetails model) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(model.name),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined)),
        ],
      ),
    );
