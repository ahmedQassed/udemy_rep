class ShopFavModel {
  late bool status;
  late String message;

  ShopFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
