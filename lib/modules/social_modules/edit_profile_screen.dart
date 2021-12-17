import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/shared/component/componant.dart';
import 'package:line_icons/line_icons.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var Cubitmodel = SocialCubit.get(context).model;
        var cubit = SocialCubit.get(context);

        nameController.text = Cubitmodel!.name;
        bioController.text = Cubitmodel.bio;
        phoneController.text = Cubitmodel.phone;

        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Page'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  LineIcons.arrowLeft,
                  color: Colors.black,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  // cubit.uploadProfileImage();
                  // cubit.uploadCoverImage();
                  cubit.updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    height: 230.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                        image: cubit.coverImage == null
                                            ? NetworkImage(Cubitmodel.cover)
                                            : FileImage(cubit.coverImage!)
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                  radius: 14.0,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      cubit.pickCoverImage();
                                    },
                                    icon: Icon(LineIcons.camera),
                                    iconSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage(Cubitmodel.image)
                                    : FileImage(cubit.profileImage!)
                                        as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 18.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 14.0,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    cubit.pickProfileImage();
                                  },
                                  icon: Icon(LineIcons.camera),
                                  iconSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  if (state is LoadingUpdateCoverImage ||
                      state is LoadingUpdateProfileImage)
                    CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  SizedBox(
                    height: 40.0,
                  ),
                  // if (cubit.coverImage != null || cubit.profileImage != null)
                  Row(
                    children: [
                      ConditionalBuilder(
                          condition: state is SuccessChangeCoverSocial,
                          builder: (context) => Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: OutlinedButton(
                                    onPressed: () {
                                      cubit.uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    child: Text('Save Cover')),
                              )),
                          fallback: (context) => Container()),
                      ConditionalBuilder(
                          condition: state is SuccessChangeProfileSocial,
                          builder: (context) => Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: OutlinedButton(
                                      onPressed: () {
                                        cubit.uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                      },
                                      child: Text('Save Profile')),
                                ),
                              ),
                          fallback: (context) => Container()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: defaultField(
                        Controller: nameController,
                        type: TextInputType.name,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          } else {
                            return null;
                          }
                        },
                        lbName: 'name',
                        pre: Icons.person_outlined),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: defaultField(
                        Controller: bioController,
                        type: TextInputType.text,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'bio must not be empty';
                          } else {
                            return null;
                          }
                        },
                        lbName: 'bio',
                        pre: LineIcons.infoCircle),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: defaultField(
                        Controller: phoneController,
                        type: TextInputType.number,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          } else {
                            return null;
                          }
                        },
                        lbName: 'phone',
                        pre: LineIcons.phone),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
