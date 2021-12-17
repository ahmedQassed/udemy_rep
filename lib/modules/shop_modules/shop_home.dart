import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/news_modules/search.dart';
import 'package:im/modules/shop_modules/search_shop_page.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/network/local/cache_helper.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, ShopSearchPage());
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          body: cubit.BottomScreens[cubit.currentPage],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.ChangeBottomPage(index);
            },
            currentIndex: cubit.currentPage,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
