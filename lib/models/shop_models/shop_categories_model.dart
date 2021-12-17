class ShopCategoriesModel {
  late bool status;
  late DataModel data;

  ShopCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int currentPage;
  late List<DataDetails> details = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((element) {
      details.add(DataDetails.fromJson(element));
    });
  }
}

class DataDetails {
  late int id;
  late String name;
  late String image;

  DataDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
