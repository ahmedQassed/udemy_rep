class ShopHomeModel {
  late bool status;
  late dataModel data;

  ShopHomeModel.json(Map<String, dynamic> JSON) {
    status = JSON['status'];
    data = dataModel.json(JSON['data']);
  }
}

class dataModel {
  List<banners> ban = [];
  List<products> pro = [];

  dataModel.json(Map<String, dynamic> JSON) {
    JSON['banners'].forEach((element) {
      ban.add(banners.json(element));
    });

    JSON['products'].forEach((element) {
      pro.add(products.json(element));
    });
  }
}

class banners {
  late int id;
  late String image;

  banners.json(Map<String, dynamic> JSON) {
    id = JSON['id'];
    image = JSON['image'];
  }
}

class products {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  products.json(Map<String, dynamic> JSON) {
    id = JSON['id'];
    price = JSON['price'];
    oldPrice = JSON['old_price'];
    discount = JSON['discount'];
    image = JSON['image'];
    name = JSON['name'];
    inFavorites = JSON['in_favorites'];
    inCart = JSON['in_cart'];
  }
}
