import 'dart:convert';
import 'dart:io';

import 'package:bokkuyon/core/constante/api.dart';
import 'package:bokkuyon/core/models/location_model.dart';
import 'package:bokkuyon/core/models/response_form_model.dart';
import 'package:bokkuyon/core/models/ride_add_model.dart';
import 'package:bokkuyon/core/models/ride_list_model.dart';
import 'package:bokkuyon/core/models/ride_reservation_model.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class RideRepository {
  static String mainPath="$apiUrl/user/rides";

  static Future<ResponseFormModel?> addRide(RideAddModel ride)async{
    try {
      final response= await http.post(
        Uri.parse(mainPath),
         headers: {
          HttpHeaders.contentTypeHeader:"application/json",
          HttpHeaders.authorizationHeader: "Bearer ${UserService.tokenResponse!.token}",

        },
        body: ride.toJson()
      );

      if (response.statusCode==200 && json.decode(response.body)["status"]==200) {
        return ResponseFormModel(isValid: true,message: "Votre tajet a bien été ajouté");

      }
      else{
        return ResponseFormModel(isValid: false,message: "Vous avez déjà un trajet pour cette date");
      }
      
    } catch (e) {
      print("failed");
      print(e);
    }
  }
  static Future<List<RideListModel>?>findMyRide()async{
    try {
       var path="$mainPath?role=${UserService.tokenResponse!.activeRole! ?'driver':'client'}&idUser=${UserService.tokenResponse!.id}";
       
      final response =await http.get(
        Uri.parse(path),
        headers:  {
          HttpHeaders.contentTypeHeader:"application/json; charset=UTF-8",          
          HttpHeaders.authorizationHeader: "Bearer ${UserService.tokenResponse!.token}",

        },        
      );

      if (response.statusCode==200) {
        final decodedBody = utf8.decode(response.bodyBytes);
      
      final jsonResponse = json.decode(decodedBody)["results"];
        
         List<RideListModel> rides=[];
         for (var map in jsonResponse) {
           rides.add(RideListModel.fromMap(map));
         } 
         return rides;
      }
      
    } catch (e) {
      
    }

  }

  static Future<List<RideReservationModel>?>findTripsByDepartureAndArrival(String departure, String arrival)async{
    try {
      String date=DateFormat('yyyy-MM-dd').format(DateTime.now());
      var path="$mainPath/reservation";
      final response = await http.post(
        Uri.parse(path),
        headers: {
          HttpHeaders.contentTypeHeader:"application/json; charset=UTF-8",
          HttpHeaders.authorizationHeader: "Bearer ${UserService.tokenResponse!.token}"
        },
        body: LocationModel(departure: departure, arrival: arrival, date: date, idClient: UserService.tokenResponse!.id).toJson()
      );
      
      if (response.statusCode==200) {
        final jsonResponse=json.decode(response.body)["results"];
       
        print(path);
         List<RideReservationModel> rides=[];
         for (var map in jsonResponse) {
           rides.add(RideReservationModel.fromMap(map));
         } 
         print(rides);
         return rides;
      }
      
    } catch (e) {
      return null;
    }
  }

  

  
  
}