import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im/modules/shop_modules/shop_home.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_cubit.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_states.dart';
import 'package:im/modules/shop_modules/shop_register/shop_register.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/modules/social_modules/social_home_screen.dart';
import 'package:im/modules/social_modules/social_register_screen.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';
import 'package:im/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SuccessLoginSocial) {
          CacheHelper.SaveData(key: 'uid', value: state.uid);
          uid = state.uid;
          navigateAndFinish(context, SocialHomeScreen());
          SocialCubit.get(context).getSocialUserData();
        }
        if (state is ErrorLoginSocial) {
          ShowToast(text: 'error', c: messageColor.ERROR);
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
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
                      const Text(
                        'login',
                        style: TextStyle(fontSize: 30.0),
                      ),
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
                      const SizedBox(
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
                      const SizedBox(
                        height: 50.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingLoginSocial,
                        builder: (context) => defaultButton(
                            text: 'LOGIN',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.loginSocialInfo(emailController.text,
                                    passwordController.text);
                              }
                            }),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
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
    );
  }
}
