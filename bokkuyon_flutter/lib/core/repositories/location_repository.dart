import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationRepository {
  static String apiKey ="AIzaSyA9EaZH_WIARHdQgSWa69ud_4KFy7rV1VM";
  static  String token="1234567890";

  static String bassedUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";



  static Future<dynamic> findLocationsOnChange(String input)async{
    try {
      var response =await http.get(
        Uri.parse("$bassedUrl?input=$input&key=$apiKey&sessionToken=$token&components=country:SN")
      );
     
     
      if (response.statusCode==200) {
         var data = json.decode(response.body);
         
         return data["predictions"];
      }
      else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> getDrivingDuration(String origin, String destination) async {
  String baseUrl = "https://maps.googleapis.com/maps/api/distancematrix/json";
  Uri uri = Uri.parse(
    "$baseUrl?origins=$origin&destinations=$destination&key=$apiKey&mode=driving"
  );

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final duration = data['rows'][0]['elements'][0]['duration']['text'];
      print("Durée en voiture : $duration");
    } else {
      print("Erreur lors de la requête : ${response.statusCode}");
    }
  } catch (e) {
    print("Erreur : $e");
  }
}

  
  
}