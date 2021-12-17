import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/shared/component/componant.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import 'feeds_screen.dart';

class PostScreen extends StatelessWidget {
  var postController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SuccessUploadCreatedPost) {
          Navigator.pop(context);
        }
      },
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
            actions: [
              TextButton(
                onPressed: () {
                  if (cubit.postImage == null)
                    cubit.uploadCreatedPost(
                        date: now.toString(), post: postController.text);

                  if (cubit.postImage != null)
                    cubit.uploadPostImageAndCreatedPost(
                        date: now.toString(), post: postController.text);
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            title: const Text('Create Post'),
          ),
          body: ConditionalBuilder(
              condition:
                  state is! LoadingGetUserDataSocial && cubit.model != null,
              builder: (context) => Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        if (state is LoadingCreatedPost ||
                            state is LoadinguploadPostImageAndCreatedPost)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage:
                                  NetworkImage('${cubit.model?.image}'),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${cubit.model?.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          letterSpacing: 0.0, height: 1.0),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLines: 40,
                            controller: postController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'what\'s on your mind...',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        if (cubit.postImage != null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image(
                                image: FileImage(cubit.postImage!),
                                height: 200.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      foregroundColor: Colors.red,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          cubit.removePostImage();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                        ),
                                      ))),
                            ],
                          ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    cubit.pickPostImage();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(LineIcons.photoVideo),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text('Add photo'),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text('# Tags'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              fallback: (context) =>
                  Center(child: const CircularProgressIndicator())),
        );
      },
    );
  }
}
