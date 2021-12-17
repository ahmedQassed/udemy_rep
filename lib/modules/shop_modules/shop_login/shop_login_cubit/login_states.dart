import 'package:im/models/shop_models/shop_login_model.dart';

abstract class LoginStates {}

class InitionalLoginStates extends LoginStates {}

class SuccessLoginStates extends LoginStates {
  final ShopLoginModel model;
  SuccessLoginStates(this.model);
}

class ErrorLoginStates extends LoginStates {
  ErrorLoginStates(error);
}

class LoadingLoginStates extends LoginStates {}

class visibPass extends LoginStates {}
