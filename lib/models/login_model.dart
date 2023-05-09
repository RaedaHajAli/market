// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  final bool status;
  final String? message;
  final UserData? data;
  LoginModel({
    required this.status,
    this.message,
    this.data,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(status: json['status'],
    message: json['message'],
    data: json['data']!=null? UserData.fromJson(json['data']):null
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final dynamic points;
  final dynamic credit;
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    required this.points,
    required this.credit,
  });
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        token: json['token'],
        points: json['points'],
        credit: json['credit']);
  }
}
