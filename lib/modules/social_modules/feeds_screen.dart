import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/social_models/social_posts_model.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/shared/component/componant.dart';

import 'comment_screen.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SuccessCreateComment) {
            commentController = TextEditingController();
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(5.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/indoor-shot-male-advertiser-manager-covered-with-sticky-adhesive-notes-looks-aside-as-notices-something-interesting-poses-against-yellow-wall-free-space-your-advertising-content_273609-42336.jpg',
                        ),
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Share With Friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          )),
                    ],
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        postItem(cubit.posts[index], context, index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 3.0,
                        ),
                    itemCount: cubit.posts.length),
              ],
            ),
          );
        },
      );
    });
  }

  var commentController = TextEditingController();

  Widget postItem(SocialPostsModel m, context, index) => Card(
        //margin: EdgeInsets.all(5.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(m.image),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            m.name,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(letterSpacing: 0.0, height: 1.0),
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15.0,
                          ),
                        ],
                      ),
                      Text(
                        m.date,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                m.post,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(height: 1.5, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#software ',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#computer ',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#flutter ',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          onPressed: () {},
                          child: Text(
                            '#programming ',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              if (m.postImage != '')
                Container(
                  height: 160.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(m.postImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text('${SocialCubit.get(context).numOfLikes[index]}',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              size: 18.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                                '${SocialCubit.get(context).numOfComments[index]}',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[300],
                height: 1.0,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage:
                          NetworkImage(SocialCubit.get(context).model!.image),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, CommentScreen(index));
                          // SocialCubit.get(context).createComment(
                          //     SocialCubit.get(context).postId[index], 'hyyyy');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'write a comment....',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                      // child: TextFormField(
                      //   onFieldSubmitted: (value) {
                      //     SocialCubit.get(context).createComment(
                      //         SocialCubit.get(context).postId[index],
                      //         commentController.text);
                      //   },
                      //   maxLines: 1,
                      //   controller: commentController,
                      //   keyboardType: TextInputType.text,
                      //   decoration: InputDecoration(
                      //     border: InputBorder.none,
                      //     hintText: 'write a comment...',
                      //   ),
                      // ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).createLikes(
                            SocialCubit.get(context).postId[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text('Like',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
            ],
          ),
        ),
      );
}
