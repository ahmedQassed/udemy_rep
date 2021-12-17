import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_categories_model.dart';
import 'package:im/models/shop_models/shop_fav_model.dart';
import 'package:im/models/shop_models/shop_get_fav_model.dart';
import 'package:im/models/shop_models/shop_home_model.dart';
import 'package:im/models/shop_models/shop_login_model.dart';
import 'package:im/models/shop_models/shop_profile_model.dart';
import 'package:im/models/shop_models/shop_search_model.dart';
import 'package:im/modules/shop_modules/categories_page.dart';
import 'package:im/modules/shop_modules/favorites_page.dart';
import 'package:im/modules/shop_modules/products_page.dart';
import 'package:im/modules/shop_modules/settings_page.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/shared/component/const.dart';
import 'package:im/shared/network/end_points.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentPage = 0;

  List<Widget> BottomScreens = [
    ProductsPage(),
    CategoriesPage(),
    FavoritesPage(),
    SettingsPage()
  ];

  void ChangeBottomPage(index) {
    currentPage = index;

    emit(BottomNavShopState());
  }

  ShopHomeModel? home;

  Map<int, bool> favorites = {};

  void HomeData() {
    emit(LoadingHomeState());

    DioHelper.getDate(urlMethod: HOME, token: token).then((value) {
      home = ShopHomeModel.json(value.data);

      home!.data.pro.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      print(favorites[0].toString());

      emit(SuccessHomeState());
    }).catchError((onError) {
      emit(ErrorHomeState());
      print(onError.toString());
    });
  }

  ShopCategoriesModel? categoriesModel;

  void CategoriesData() {
    DioHelper.getDate(urlMethod: Categories).then((value) {
      categoriesModel = ShopCategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);

      print(categoriesModel!.data.details.length);

      emit(SuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCategoriesState());
    });
  }

  ShopFavModel? shopFavModel;

  void changeFav(int idProduct) {
    favorites[idProduct] = !(favorites[idProduct])!;
    emit(SuccessColorFavState());

    DioHelper.postData(
      url: fav,
      Data: {'product_id': idProduct},
      token: token,
    ).then((value) {
      shopFavModel = ShopFavModel.fromJson(value.data);

      print(shopFavModel!.message);

      if (!shopFavModel!.status) {
        favorites[idProduct] = !(favorites[idProduct])!;
      } else {
        if (shopGetFavModel != null) {
          getFav();
        }
      }

      emit(SuccessFavState(shopFavModel!));
    }).catchError((onError) {
      favorites[idProduct] = !(favorites[idProduct])!;

      emit(ErrorFavState());
    });
  }

  ShopGetFavModel? shopGetFavModel;

  void getFav() {
    emit(LoadingGetFav());

    DioHelper.getDate(urlMethod: fav, token: token).then((value) {
      shopGetFavModel = ShopGetFavModel.fromJson(value.data);

      emit(SuccessGetFav());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFav());
    });
  }

  ShopProfileModel? file;

  void getProfile() {
    emit(LoadingProfile());

    DioHelper.getDate(urlMethod: profile, token: token).then((value) {
      file = ShopProfileModel.fromJs(value.data);

      emit(SuccessProfile());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorProfile());
    });
  }

  late ShopLoginModel model;

  void updateInfo(
      {required String name, required String email, required String phone}) {
    emit(LoadingUpdateState());

    DioHelper.putData(
            url: UPDATE_PROFILE,
            Data: {
              'name': name,
              'email': email,
              'phone': phone,
            },
            token: token)
        .then((value) {
      model = ShopLoginModel.fromJs(value.data);

      emit(SuccessUpdateState(model));
    }).catchError((onError) {
      emit(ErrorUpdateState());
      print(onError.toString());
    });
  }

  ShopSearchModel? m;

  void getSearch(searchText) {
    emit(LoadingSearch());

    DioHelper.postData(url: SEARCH, token: token, Data: {
      'text': searchText,
    }).then((value) {
      m = ShopSearchModel.fromJson(value.data);
      // print(m!.data!.dataa[0].oldPrice);
      // print(value.toString());

      emit(SuccessSearch());
    }).catchError((onError) {
      print(onError.toString());

      emit(ErrorSearch());
    });
  }
}
