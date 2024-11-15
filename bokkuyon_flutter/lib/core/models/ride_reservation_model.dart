import 'dart:convert';

import 'package:bokkuyon/core/models/location_model.dart';

class RideReservationModel {
  int id;
  String departure;
  String arrival;
  int seats;
  int price;

  RideReservationModel(
    {
      required this.id,
      required this.departure,
      required this.arrival,
      required this.seats,
      required this.price,
    }
  );

  factory RideReservationModel.fromMap(Map<String,dynamic>map){
    return RideReservationModel(id: map["id"], 
    departure:map["departure"] , 
    arrival:map["arrival"],
    seats: map["seats"], 
    price: map["price"]);
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":id,
      "departure":departure,
      "arrival":arrival,     
      "seats":seats,
      
    };
  }
    String toJson ()=>json.encode(toMap()); 
  
}