class ShopRegisterModel {
  late bool status;
  late String message;
  dade? data;

  ShopRegisterModel.fromJs(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? dade.fromJson(json['data']) : null;
  }
}

class dade {
  late String name;
  late String email;
  late String phone;
  late int id;
  late String image;
  late String token;

  dade.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
