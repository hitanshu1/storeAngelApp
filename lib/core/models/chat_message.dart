import 'package:storeangelApp/core/models/user.dart';

class ChatMessage{
  String message;
  UserModel sendBy;
  DateTime createdAt;
  ChatMessage({this.createdAt,this.message,this.sendBy});
}