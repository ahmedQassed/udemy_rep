import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/social_models/social_posts_model.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:line_icons/line_icons.dart';

class CommentScreen extends StatelessWidget {
  int? inde;

  CommentScreen(this.inde);

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                LineIcons.arrowLeft,
                color: Colors.black,
              ),
            ),
            title: const Text('add a comment'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) => commentItem(context, inde),
              separatorBuilder: (context, index) => Container(
                    height: 1.0,
                    width: double.infinity,
                  ),
              itemCount: 1),
        );
      },
    );
  }

  Widget commentItem(context, index) => Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              maxLines: 1,
              controller: commentController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'write a comment...',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                SocialCubit.get(context).createComment(
                    SocialCubit.get(context).postId[index],
                    commentController.text);
              },
              child: Text(
                'done',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );
}
