// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'favorite_model.dart';

class HomeModel {
  final bool status;
  final String? message;
  final HomeDataModel? data;
  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        status: json['status'],
        message: json['message'],
        data:
            json['data'] != null ? HomeDataModel.fromJson(json['data']) : null);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel({
    required this.banners,
    required this.products,
  });
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  final int id;
  final String image;
  BannerModel({
    required this.id,
    required this.image,
  });
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(id: json['id'], image: json['image']);
  }
}

class ProductModel implements Product {
  @override
  final int id;
  @override
  final dynamic price;
  @override
  final dynamic oldPrice;
  @override
  final dynamic discount;
  @override
  final String name;
  @override
  final String image;
  final String description;
  final bool inFavorite;
  final bool inCart;
  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.image,
    required this.description,
    required this.inFavorite,
    required this.inCart,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        price: json['price'],
        oldPrice: json['old_price'],
        discount: json['discount'],
        name: json['name'],
        image: json['image'],
        inFavorite: json['in_favorites'],
        description: json['description'],
        inCart: json['in_cart']);
  }
}
