
import 'package:bokkuyon/core/models/login_model.dart';
import 'package:bokkuyon/core/models/register_model.dart';
import 'package:bokkuyon/core/models/token_response_model.dart';
import 'package:bokkuyon/core/repositories/user_repositry.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserService {
  static RegisterModel ? registerModel;
  static TokenResponseModel? tokenResponse;
  static bool ? isLogged ; 
  static  LatLng? position;
  static Future<dynamic> registerUser(RegisterModel user)async{
    final dynamic response = await UserRepositry.registerUser(user);
    isLogged =response;
  }
  static Future<void>login(LoginModel loginModel)async{
   final TokenResponseModel ? response =await UserRepositry.login(loginModel);
   print("La response $response");
   tokenResponse=response; 
  }
  
}