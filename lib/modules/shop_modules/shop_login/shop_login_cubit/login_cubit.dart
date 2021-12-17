import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_login_model.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_states.dart';
import 'package:im/shared/network/end_points.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitionalLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel model;

  void LoginInfo(String email, String password) {
    emit(LoadingLoginStates());

    DioHelper.postData(url: LOGIN, Data: {
      'email': email,
      'password': password,
    }).then((value) {
      model = ShopLoginModel.fromJs(value.data);

      emit(SuccessLoginStates(model));
    }).catchError((onError) {
      emit(ErrorLoginStates(onError.toString()));
      print(onError.toString());
    });
  }

  bool isShow = true;
  IconData suffix = Icons.visibility_off_outlined;

  void ShowPass() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(visibPass());
  }
}
