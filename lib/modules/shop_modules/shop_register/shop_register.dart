import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/shop_modules/products_page.dart';
import 'package:im/modules/shop_modules/shop_home.dart';
import 'package:im/modules/shop_modules/shop_register/register_cubit/register_cubit.dart';
import 'package:im/modules/shop_modules/shop_register/register_cubit/register_states.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';
import 'package:im/shared/network/end_points.dart';
import 'package:im/shared/network/local/cache_helper.dart';
import 'package:im/shared/network/remote/dio_helper.dart';

class ShopRegister extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SuccessRegisterStates) {
            if (state.model.status) {
              CacheHelper.SaveData(key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token;
                navigateAndFinish(context, const ShopHome());
              });
            } else {
              ShowToast(text: state.model.message, c: messageColor.ERROR);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register page'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultField(
                        Controller: nameController,
                        type: TextInputType.text,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'name must be valid';
                          }
                        },
                        lbName: 'Name',
                        pre: Icons.person,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultField(
                        Controller: emailController,
                        type: TextInputType.emailAddress,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'email must be valid';
                          }
                        },
                        lbName: 'email',
                        pre: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultField(
                          Controller: passController,
                          type: TextInputType.phone,
                          vale: (value) {
                            if (value!.isEmpty) {
                              return 'password must be valid';
                            }
                          },
                          lbName: 'password',
                          pre: Icons.lock_outline,
                          suf: cubit.suffix,
                          secure: cubit.isShow,
                          f: () {
                            cubit.ShowPass();
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultField(
                        Controller: phoneController,
                        type: TextInputType.phone,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'phone must be valid';
                          }
                        },
                        lbName: 'phone',
                        pre: Icons.phone,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingRegisterStates,
                        builder: (context) => defaultButton(
                            text: 'REGISTER',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.registerInfo(
                                    nameController.text,
                                    emailController.text,
                                    passController.text,
                                    phoneController.text);
                              }
                            }),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
