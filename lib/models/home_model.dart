class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    banners = List<BannerModel>.from(
      json["banners"].map(
        (x) => BannerModel.fromJson(x),
      ),
    );
    products = List<ProductModel>.from(
      json["products"].map(
        (x) => ProductModel.fromJson(x),
      ),
    );
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
// Map<String,dynamic> bannersList = jsonDecode(json['banners']);
// Map<String,dynamic> productsList = jsonDecode(json['products']);
//
// bannersList['banners'].forEach(
//   (element) {
//     banners?.add(element);
//   },
// );
// productsList['products'].forEach(
//   (element) {
//     products?.add(element);
//   },
// );
