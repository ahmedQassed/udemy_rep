import 'package:im/models/social_models/social_register_model.dart';

abstract class SocialStates {}

class InitSocialStates extends SocialStates {}

class LoadingLoginSocial extends SocialStates {}

class SuccessLoginSocial extends SocialStates {
  final String uid;

  SuccessLoginSocial(this.uid);
}

class ErrorLoginSocial extends SocialStates {
  final error;
  ErrorLoginSocial(this.error);
}

class LoadingRegisterSocial extends SocialStates {}

class SuccessRegisterSocial extends SocialStates {}

class ErrorRegisterSocial extends SocialStates {}

class SuccessRegisterSaveSocial extends SocialStates {
  final String uid;

  SuccessRegisterSaveSocial(this.uid);
}

class ErrorRegisterSaveSocial extends SocialStates {}

class visibPPass extends SocialStates {}

class LoadingGetUserDataSocial extends SocialStates {}

class SuccessGetUserDataSocial extends SocialStates {
  // SocialRegisterModel model;
  //
  // SuccessGetUserDataSocial(this.model);
}

class ErrorGetUserDataSocial extends SocialStates {}

class LoadingFefe extends SocialStates {}

class SuccessFefe extends SocialStates {}

class ErrorFefe extends SocialStates {}

class changeB extends SocialStates {}

class changeC extends SocialStates {}

class SuccessChangeProfileSocial extends SocialStates {}

class ErrorChangeProfileSocial extends SocialStates {}

class SuccessChangeCoverSocial extends SocialStates {}

class ErrorChangeCoverSocial extends SocialStates {}

class SuccessUploadProfileImage extends SocialStates {}

class ErrorUploadProfileImage extends SocialStates {}

class ErrorGetUrlProfileImage extends SocialStates {}

class SuccessUploadCoverImage extends SocialStates {}

class ErrorUploadCoverImage extends SocialStates {}

class ErrorGetUrlCoverImage extends SocialStates {}

class ErrorUpdateUserData extends SocialStates {}

class SuccessUpdateProfileImage extends SocialStates {}

class SuccessUpdateCoverImage extends SocialStates {}

class LoadingUpdateProfileImage extends SocialStates {}

class LoadingUpdateCoverImage extends SocialStates {}

class ErrorUploadCreatedPost extends SocialStates {}

class SuccessUploadCreatedPost extends SocialStates {}

class SuccessChangePostImage extends SocialStates {}

class ErrorChangePostImage extends SocialStates {}

class ErrorUploadImageAndCreatedPost extends SocialStates {}

class SuccessUploadImageAndCreatedPost extends SocialStates {}

class ErrorUploadPostImage extends SocialStates {}

class removePostImageState extends SocialStates {}

class LoadinguploadPostImageAndCreatedPost extends SocialStates {}

class LoadingCreatedPost extends SocialStates {}

class SuccessGetPosts extends SocialStates {}

class ErrorGetPosts extends SocialStates {}

class SuccessCreateLike extends SocialStates {}

class ErrorCreateLike extends SocialStates {}

class SuccessGetLike extends SocialStates {}

class ErrorGetLike extends SocialStates {}

class SuccessCreateComment extends SocialStates {}

class ErrorCreateComment extends SocialStates {}

class ErrorGetComments extends SocialStates {}

class test extends SocialStates {}

class ErrorGetAllUsers extends SocialStates {}

class SuccessGetAllUsers extends SocialStates {}

class ErrorSendMessage extends SocialStates {}

class SuccessSendMessage extends SocialStates {}

class ErrorSendMyMessage extends SocialStates {}

class SuccessSendMyMessage extends SocialStates {}

class SuccessGetMessages extends SocialStates {}

class SuccessGetComments extends SocialStates {}

class ErrorGettComments extends SocialStates {}
