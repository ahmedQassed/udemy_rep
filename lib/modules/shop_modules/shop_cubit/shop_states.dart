import 'package:im/models/shop_models/shop_fav_model.dart';
import 'package:im/models/shop_models/shop_login_model.dart';

abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class BottomNavShopState extends ShopStates {}

class LoadingHomeState extends ShopStates {}

class SuccessHomeState extends ShopStates {}

class ErrorHomeState extends ShopStates {}

class SuccessCategoriesState extends ShopStates {}

class ErrorCategoriesState extends ShopStates {}

class SuccessFavState extends ShopStates {
  final ShopFavModel model;

  SuccessFavState(this.model);
}

class ErrorFavState extends ShopStates {}

class SuccessColorFavState extends ShopStates {}

class SuccessGetFav extends ShopStates {}

class ErrorGetFav extends ShopStates {}

class LoadingGetFav extends ShopStates {}

class SuccessProfile extends ShopStates {}

class ErrorProfile extends ShopStates {}

class LoadingProfile extends ShopStates {}

class LoadingUpdateState extends ShopStates {}

class SuccessUpdateState extends ShopStates {
  final ShopLoginModel model;
  SuccessUpdateState(this.model);
}

class ErrorUpdateState extends ShopStates {}

class SuccessSearch extends ShopStates {}

class ErrorSearch extends ShopStates {}

class LoadingSearch extends ShopStates {}
