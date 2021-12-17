import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_states.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/network/local/cache_helper.dart';

class SettingsPage extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is SuccessUpdateState) {
          if (state.model.status) {
            ShopCubit.get(context).getProfile();
            ShowToast(text: state.model.message, c: messageColor.SUCCESS);
          } else {
            ShowToast(text: state.model.message, c: messageColor.ERROR);
          }
        }
      },
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).file != null
            ? ShopCubit.get(context).file!.dat!.name.toString()
            : '';
        emailController.text = ShopCubit.get(context).file != null
            ? ShopCubit.get(context).file!.dat!.email.toString()
            : '';

        phoneController.text = ShopCubit.get(context).file != null
            ? ShopCubit.get(context).file!.dat!.phone.toString()
            : '';

        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.file != null,
            builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          defaultField(
                            Controller: nameController,
                            type: TextInputType.text,
                            vale: (value) {
                              if (value!.isEmpty) {
                                'name must be valid';
                              }
                            },
                            lbName: 'Name',
                            pre: Icons.person,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultField(
                            Controller: emailController,
                            type: TextInputType.emailAddress,
                            vale: (value) {
                              if (value!.isEmpty) {
                                'email must be valid';
                              }
                            },
                            lbName: 'Email',
                            pre: Icons.email,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultField(
                            Controller: phoneController,
                            type: TextInputType.phone,
                            vale: (value) {
                              if (value!.isEmpty) {
                                'phone must be valid';
                              }
                            },
                            lbName: 'phone',
                            pre: Icons.phone,
                          ),
                          const SizedBox(
                            height: 100.0,
                          ),
                          if (state is LoadingUpdateState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 100.0,
                          ),
                          defaultButton(
                              text: 'UPDATE',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.updateInfo(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text);
                                }
                              }),
                          const SizedBox(
                            height: 60.0,
                          ),
                          defaultButton(
                              text: 'LOGOUT',
                              function: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  navigateAndFinish(context, ShopLogin());
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
