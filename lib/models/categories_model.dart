// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoriesModel {
  final bool status;
  final String? message;
  final PrimaryDataModel? data;
  CategoriesModel({
    required this.status,
    this.message,
    this.data,
  });
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null
            ? PrimaryDataModel.fromJson(json['data'])
            : null);
  }
}

class PrimaryDataModel {
  List<CategoriesData> dataList = [];
  PrimaryDataModel({
    required this.dataList,
  });
  PrimaryDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      dataList.add(CategoriesData.fromJson(element));
      
    });
  }
}

class CategoriesData {
  final int id;
  final String name;
  final String image;
  CategoriesData({
    required this.id,
    required this.name,
    required this.image,
  });
  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
        id: json['id'], name: json['name'], image: json['image']);
  }
}
