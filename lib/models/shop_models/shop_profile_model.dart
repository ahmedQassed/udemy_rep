class ShopProfileModel {
  bool? status;
  daProfile? dat;

  ShopProfileModel.fromJs(Map<String, dynamic> json) {
    status = json['status'];
    dat = json['data'] != null ? daProfile.fromJson(json['data']) : null;
  }
}

class daProfile {
  late int id;
  String? name;
  String? email;
  String? phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  daProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
