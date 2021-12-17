import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/social_modules/post_screen.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/shared/component/componant.dart';
import 'package:line_icons/line_icons.dart';

class SocialHomeScreen extends StatelessWidget {
  const SocialHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is changeB) {
          navigateTo(context, PostScreen());
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.CurrentPage]),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(LineIcons.fan)),
              IconButton(onPressed: () {}, icon: const Icon(LineIcons.search)),
            ],
          ),
          body: cubit.screens[cubit.CurrentPage],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.CurrentPage,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.weixinWechat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.arrowUp), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.userCircle), label: 'Users'),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 11.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/curly-woman-stands-sideways-has-serious-expression-dark-curly-hair-dressed-turtleneck-wears-round-earrings_273609-46784.jpg'),
                    ),
                    label: 'profile'),
              ]),
        );
      },
    );
  }
}
