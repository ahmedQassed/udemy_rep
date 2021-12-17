import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/social_models/social_message_model.dart';
import 'package:im/models/social_models/social_register_model.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:line_icons/line_icons.dart';

class SocialChatDetailsScreen extends StatelessWidget {
  SocialRegisterModel m;
  SocialChatDetailsScreen(this.m);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(receiverId: m.uid);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    LineIcons.arrowLeft,
                    color: Colors.black,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(m.image),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(m.name),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                        condition:
                            SocialCubit.get(context).messageList.isNotEmpty,
                        builder: (context) => ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (SocialCubit.get(context).model!.uid ==
                                  SocialCubit.get(context)
                                      .messageList[index]
                                      .senderId) {
                                return myMessageItem(
                                    SocialCubit.get(context).messageList[index],
                                    context);
                              } else {
                                return messageItem(
                                    SocialCubit.get(context).messageList[index],
                                    context);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 5.0),
                            itemCount:
                                SocialCubit.get(context).messageList.length),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator())),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.0),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'write a message...'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          IconButton(
                            onPressed: () {
                              if (messageController.text.isNotEmpty)
                                SocialCubit.get(context).sendMessage(
                                    receiverId: m.uid,
                                    message: messageController.text,
                                    time: DateTime.now().toString());
                              messageController.clear();
                            },
                            icon: Icon(Icons.send),
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      );
    });
  }

  Widget messageItem(SocialMessageModel mo, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15.0),
                topStart: Radius.circular(15.0),
                bottomEnd: Radius.circular(15.0),
              ),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                mo.message,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ),
      );

  Widget myMessageItem(SocialMessageModel my, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(15.0),
                topStart: Radius.circular(15.0),
                bottomStart: Radius.circular(15.0),
              ),
              color: Colors.blue.withOpacity(.2),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                my.message,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ),
      );
}
