import 'package:storeangelApp/core/models/user.dart';

class AuthResponseModel{
  int statusCode;
  String message;
  UserModel user;
  AuthResponseModel({this.user,this.message,this.statusCode});
}