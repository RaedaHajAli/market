import 'package:market/models/home_model.dart';



class SearchModel {
  final bool status;
  final String? message;
  final SearchDataModel? data;
  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        status: json['status'],
        message: json['message'],
        data:
            json['data'] != null ? SearchDataModel.fromJson(json['data']) : null);
  }
}

class SearchDataModel {
 
  List<ProductModel> data = [];
 SearchDataModel({
   
    required this.data,
  });
 SearchDataModel.fromJson(Map<String, dynamic> json) {
    
   
    json['data'].forEach((element) {
      data.add(ProductModel.fromJson(element));
    });
  }
}




