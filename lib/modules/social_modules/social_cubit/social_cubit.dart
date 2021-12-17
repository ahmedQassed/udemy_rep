import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/models/social_models/social_message_model.dart';
import 'package:im/models/social_models/social_posts_model.dart';
import 'package:im/models/social_models/social_register_model.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login_cubit/login_states.dart';
import 'package:im/modules/social_modules/chats_screen.dart';
import 'package:im/modules/social_modules/feeds_screen.dart';
import 'package:im/modules/social_modules/setting_screen.dart';
import 'package:im/modules/social_modules/social_cubit/social_states.dart';
import 'package:im/modules/social_modules/users_screen.dart';
import 'package:im/shared/component/componant.dart';
import '../post_screen.dart';
import 'package:im/shared/component/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitSocialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  void registerSocialInfo(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(LoadingRegisterSocial());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveRegisterInfo(
          name: name, email: email, phone: phone, uid: value.user!.uid);
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorRegisterSocial());
    });
  }

  void saveRegisterInfo({
    required String name,
    required String email,
    required String phone,
    required String uid,
    String image =
        'https://image.freepik.com/free-photo/curly-woman-stands-sideways-has-serious-expression-dark-curly-hair-dressed-turtleneck-wears-round-earrings_273609-46784.jpg',
    String cover =
        'https://image.freepik.com/free-photo/curly-woman-stands-sideways-has-serious-expression-dark-curly-hair-dressed-turtleneck-wears-round-earrings_273609-46784.jpg',
    String bio = 'write your bio...',
  }) {
    SocialRegisterModel model = SocialRegisterModel(
      name: name,
      email: email,
      phone: phone,
      image: image,
      cover: cover,
      bio: bio,
      uid: uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SuccessRegisterSaveSocial(uid));
    }).catchError((onError) {
      emit(ErrorRegisterSaveSocial());
    });
  }

  void loginSocialInfo(String email, String password) {
    emit(LoadingLoginSocial());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SuccessLoginSocial(value.user!.uid));
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorLoginSocial(onError.toString()));
    });
  }

  SocialRegisterModel? model;

  void getSocialUserData() {
    emit(LoadingGetUserDataSocial());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model = SocialRegisterModel.fromJson(value.data()!);

      print('ew3aaaa : ${model!.name}');

      emit(SuccessGetUserDataSocial());
    }).catchError((onError) {
      print(onError.toString());

      emit(ErrorGetUserDataSocial());
    });
  }

  void fefe() {
    emit(LoadingFefe());

    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      emit(SuccessFefe());
      ShowToast(text: 'check your mail', c: messageColor.SUCCESS);
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorFefe());
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'posts',
    'Users',
    'Setting',
  ];

  int CurrentPage = 0;

  void changeBottom(int index) {
    if (index == 1) getAllUsers();

    if (index == 2)
      emit(changeB());
    else {
      CurrentPage = index;
      emit(changeC());
    }
  }

  bool isShow = true;
  IconData suffix = Icons.visibility_off_outlined;

  void ShowPass() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(visibPPass());
  }

  File? profileImage;
  File? coverImage;

  File? postImage;

  var picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final pickedProfileFile =
        await picker.getImage(source: ImageSource.gallery);

    if (pickedProfileFile != null) {
      profileImage = File(pickedProfileFile.path);

      emit(SuccessChangeProfileSocial());
    } else {
      print('add image');

      emit(ErrorChangeProfileSocial());
    }
  }

  Future<void> pickCoverImage() async {
    final pickedCoverFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedCoverFile != null) {
      coverImage = File(pickedCoverFile.path);

      emit(SuccessChangeCoverSocial());
    } else {
      print('add cover');

      emit(ErrorChangeCoverSocial());
    }
  }

  Future<void> pickPostImage() async {
    final pickedPostFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedPostFile != null) {
      postImage = File(pickedPostFile.path);

      emit(SuccessChangePostImage());
    } else {
      print('add postImage');

      emit(ErrorChangePostImage());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(LoadingUpdateProfileImage());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // emit(SuccessUploadProfileImage());
        updateUserData(name: name, phone: phone, bio: bio, image: value);
        emit(SuccessUpdateProfileImage());
      }).catchError((onError) {
        emit(ErrorGetUrlProfileImage());
      });
    }).catchError((onError) {
      emit(ErrorUploadProfileImage());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(LoadingUpdateCoverImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        // emit(SuccessUploadCoverImage());
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
        emit(SuccessUpdateCoverImage());
      }).catchError((onError) {
        emit(ErrorGetUrlCoverImage());
      });
    }).catchError((onError) {
      emit(ErrorUploadCoverImage());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialRegisterModel up = SocialRegisterModel(
      name: name,
      email: model!.email,
      phone: phone,
      bio: bio,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      uid: model!.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(up.toMap())
        .then((value) {
      getSocialUserData();
    }).catchError((onError) {
      emit(ErrorUpdateUserData());
    });
  }

  void uploadPostImageAndCreatedPost({
    required String date,
    required String post,
  }) {
    emit(LoadinguploadPostImageAndCreatedPost());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(Uri.file(postImage!.path).pathSegments.last)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadCreatedPost(date: date, post: post, postImage: value);

        emit(SuccessUploadImageAndCreatedPost());
      }).catchError((onError) {
        emit(ErrorUploadImageAndCreatedPost());
      });
    }).catchError((onError) {
      emit(ErrorUploadPostImage());
    });
  }

  void uploadCreatedPost({
    required String date,
    required String post,
    String? postImage,
  }) {
    emit(LoadingCreatedPost());

    SocialPostsModel postModel = SocialPostsModel(
        name: model!.name,
        date: date,
        image: model!.image,
        post: post,
        postImage: postImage ?? '',
        uid: model!.uid);

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SuccessUploadCreatedPost());
    }).catchError((onError) {
      emit(ErrorUploadCreatedPost());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(removePostImageState());
  }

  List<SocialPostsModel> posts = [];
  List<String> postId = [];
  List<int> numOfLikes = [];
  List<int> numOfComments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((likesValue) {
          element.reference.collection('comments').get().then((commentValue) {
            numOfLikes.add(likesValue.docs.length);
            numOfComments.add(commentValue.docs.length);

            postId.add(element.id);
            posts.add(SocialPostsModel.fromJson(element.data()));

            emit(SuccessGetPosts());
          }).catchError((onError) {
            emit(ErrorGetComments());
          });
        }).catchError((onError) {
          emit(ErrorGetLike());
        });
      });
    }).catchError((onError) {
      emit(ErrorGetPosts());
    });
  }

  void createLikes(postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({'like': true}).then((value) {
      emit(SuccessCreateLike());
    }).catchError((onError) {
      emit(ErrorCreateLike());
    });
  }

  void createComment(postId, String myComment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uid)
        .set({'comment': myComment}).then((value) {
      emit(SuccessCreateComment());
    }).catchError((onError) {
      emit(ErrorCreateComment());
    });
  }

  List<SocialRegisterModel> users = [];

  void getAllUsers() {
    if (users.isEmpty)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model!.uid)
            users.add(SocialRegisterModel.fromJson(element.data()));

          emit(SuccessGetAllUsers());
        });
      }).catchError((onError) {
        print(onError.toString());
        emit(ErrorGetAllUsers());
      });
  }

  void sendMessage({
    required String receiverId,
    required String message,
    required String time,
  }) {
    SocialMessageModel mode = SocialMessageModel(
        senderId: model!.uid,
        receiverId: receiverId,
        message: message,
        time: time);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(mode.toMap())
        .then((value) {
      emit(SuccessSendMyMessage());
    }).catchError((onError) {
      emit(ErrorSendMyMessage());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(mode.toMap())
        .then((value) {
      emit(SuccessSendMessage());
    }).catchError((onError) {
      emit(ErrorSendMessage());
    });
  }

  late List<SocialMessageModel> messageList = [];

  void getMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      messageList = [];

      event.docs.forEach((element) {
        messageList.add(SocialMessageModel.fromJson(element.data()));
      });

      emit(SuccessGetMessages());
    });
  }
}

// //
// element.reference.collection('comments').get().then((value) {
// numOfComments.add(value.docs.length);
// postId.add(element.id);
// posts.add(SocialPostsModel.fromJson(element.data()));
//
// emit(SuccessGetPosts());
// }).catchError((onError) {
// emit(ErrorGetComments());
// });
// //
