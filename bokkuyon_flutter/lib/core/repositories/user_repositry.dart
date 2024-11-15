import 'dart:convert';
import 'dart:io';

import 'package:bokkuyon/core/constante/api.dart';
import 'package:bokkuyon/core/models/login_model.dart';
import 'package:bokkuyon/core/models/register_model.dart';
import 'package:bokkuyon/core/models/token_response_model.dart';
import 'package:http/http.dart' as http;
class UserRepositry {
  static Future<dynamic>registerUser(RegisterModel user)async{
    var path="$apiUrl/register";
    try {
      final response = await http.post(
        Uri.parse(path),
        headers: {
          HttpHeaders.contentTypeHeader:"application/json",
        },
        body: user.toJson()
      );

     
      
      if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["status"]==200) {
        return true;
      }
      return false;
        
      }
      else{
        return false;
      }
      
    } catch (e,stackTrace) {
      return null;
    }
  }

  static Future<TokenResponseModel?>login(LoginModel loginModel)async{

    try {
      var path="$apiUrl/login";
      final response = await http.post(
        Uri.parse(path),
        headers: {
          HttpHeaders.contentTypeHeader:"application/json"
        },
        body: loginModel.toJson()
      );

     print(response.body);
      if (response.statusCode==200) {
         final jsonResponse = json.decode(response.body)["results"];
         print("llllll");
         print(TokenResponseModel.fromMap(jsonResponse));
         print("AAAAAAAA $jsonResponse");
         return TokenResponseModel.fromMap(jsonResponse);
      }
      
      
    } catch (e) {
      return null;
    }

  }
  
}