import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/shop_models/shop_register_model.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_states.dart';
import 'package:im/modules/shop_modules/shop_register/register_cubit/register_states.dart';
import 'package:im/shared/network/end_points.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

import '../../categories_page.dart';
import '../../favorites_page.dart';
import '../../products_page.dart';
import '../../settings_page.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitionalRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late ShopRegisterModel model;

  void registerInfo(String name, String email, String password, String phone) {
    emit(LoadingRegisterStates());

    DioHelper.postData(url: register, Data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      model = ShopRegisterModel.fromJs(value.data);

      emit(SuccessRegisterStates(model));
    }).catchError((onError) {
      emit(ErrorRegisterStates(onError.toString()));
      print(onError.toString());
    });
  }

  bool isShow = true;
  IconData suffix = Icons.visibility_off_outlined;

  void ShowPass() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(visiPass());
  }
}
