import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TokenResponseModel {
  int id;
  String username;
  String phone;
  List<String>roles;
  String token;
  bool? activeRole;
 

  TokenResponseModel(
    {
      required this.id,
      required this.username,
      required this.phone,
      required this.roles,
      required this.token,
      this.activeRole,
     
    }
  );

  factory TokenResponseModel.fromMap(Map<String,dynamic>map){
    return TokenResponseModel(id: map["id"],
     username: map["username"], 
     phone: map["phone"],
      roles: List<String>.from(map["roles"]),
       token: map["token"]);
  }
  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      "id":id,
      "username":username,
      "token":token,
      "phone":phone,
      "roles":roles
    };
  }

  String toJson ()=>json.encode(toMap());
  
}