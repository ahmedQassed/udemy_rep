import 'package:im/models/shop_models/shop_register_model.dart';

abstract class RegisterStates {}

class InitionalRegisterStates extends RegisterStates {}

class SuccessRegisterStates extends RegisterStates {
  final ShopRegisterModel model;
  SuccessRegisterStates(this.model);
}

class ErrorRegisterStates extends RegisterStates {
  ErrorRegisterStates(error);
}

class LoadingRegisterStates extends RegisterStates {}

class visiPass extends RegisterStates {}

class BottomNavShopState extends RegisterStates {}
