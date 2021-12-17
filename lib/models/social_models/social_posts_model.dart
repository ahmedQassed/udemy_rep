class SocialPostsModel {
  late String name;
  late String date;
  late String image;
  late String post;
  late String postImage;
  late String uid;

  SocialPostsModel({
    required this.name,
    required this.date,
    required this.image,
    required this.post,
    required this.postImage,
    required this.uid,
  });

  SocialPostsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    image = json['image'];
    post = json['post'];
    postImage = json['postImage'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'image': image,
      'post': post,
      'postImage': postImage,
      'uid': uid,
    };
  }
}
