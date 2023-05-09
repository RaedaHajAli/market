// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteModel {
  final bool status;
  final String? message;
  final FavoriteDataModel? data;
  FavoriteModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null
            ? FavoriteDataModel.fromJson(json['data'])
            : null);
  }
}

class FavoriteDataModel {
  List<FavoriteProductData> data = [];
  FavoriteDataModel({
    required this.data,
  });
  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteProductData.fromJson(element));
    });
  }
}

class FavoriteProductData {
  final int id;
  final Product product;
  FavoriteProductData({
    required this.id,
    required this.product,
  });
  factory FavoriteProductData.fromJson(Map<String, dynamic> json) {
    return FavoriteProductData(
      id: json['id'],
      product:Product.fromJson(json['product']) );
  }
}

class ProductItem {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;

  final String image;

  ProductItem({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    
    required this.image,
  });
  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
    
      image: json['image'],
    );
  }
}
class Product implements ProductItem  {
  @override
  final int id;
    @override
  final dynamic price;
    @override
  final dynamic oldPrice;
    @override
  final dynamic discount;
  final String name;
    @override
  final String image;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.image,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      name: json['name'],
      image: json['image'],
    );
  }
}