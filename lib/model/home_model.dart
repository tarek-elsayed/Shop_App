class HomeModel {
  bool status;

  HomeDateModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = HomeDateModel.fromJson(json['data']);
  }
}

class HomeDateModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDateModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  String image;
  String name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  bool inFavourites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
