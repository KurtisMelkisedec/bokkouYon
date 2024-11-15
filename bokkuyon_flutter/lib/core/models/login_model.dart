import 'dart:core';
import 'dart:convert';
class LoginModel {
  String username;
  String password;

  LoginModel({
    required this.username,
    required this.password
  });

  factory LoginModel.fromMap(Map<String,dynamic>map){
    return LoginModel(username: map["username"], password: map["password"]);
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{"username":username,"password":password};
  }
  String toJson()=>json.encode(toMap());
  
}