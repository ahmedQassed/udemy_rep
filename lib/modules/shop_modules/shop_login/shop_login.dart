import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im/modules/shop_modules/shop_home.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_cubit.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_states.dart';
import 'package:im/modules/shop_modules/shop_register/shop_register.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';
import 'package:im/shared/network/local/cache_helper.dart';

class ShopLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (Context, state) {
          if (state is SuccessLoginStates) {
            if (state.model.status) {
              CacheHelper.SaveData(key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token;
                navigateAndFinish(context, ShopHome());
              });
            } else {
              ShowToast(text: state.model.message, c: messageColor.ERROR);
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
              appBar: AppBar(),
              body: Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage('ahmed/shop3.jpg')),
                        const SizedBox(
                          height: 50.0,
                        ),
                        defaultField(
                          Controller: emailController,
                          type: TextInputType.emailAddress,
                          vale: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email!';
                            }
                          },
                          lbName: 'Email',
                          pre: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultField(
                            Controller: passwordController,
                            type: TextInputType.visiblePassword,
                            vale: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password!';
                              }
                            },
                            lbName: 'Password',
                            pre: Icons.lock_outline,
                            suf: cubit.suffix,
                            secure: cubit.isShow,
                            f: () {
                              cubit.ShowPass();
                            }),
                        SizedBox(
                          height: 50.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginStates,
                          builder: (context) => defaultButton(
                              text: 'LOGIN',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.LoginInfo(emailController.text,
                                      passwordController.text);
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t have an account ?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegister());
                                },
                                child: const Text('REGISTER')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )));
        },
      ),
    );
  }
}
