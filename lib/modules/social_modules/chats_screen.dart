import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/social_models/social_register_model.dart';
import 'package:im/modules/social_modules/social_chat_details_screen.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/shared/component/componant.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) =>
                  chatItem(cubit.users[index], context),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: cubit.users.length),
        );
      },
    );
  }

  Widget chatItem(SocialRegisterModel model, context) => Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                navigateTo(context, SocialChatDetailsScreen(model));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(model.image),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
