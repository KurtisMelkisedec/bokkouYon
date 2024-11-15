import 'dart:convert';

import 'package:bokkuyon/core/models/location_model.dart';

class RideAddModel {
  String departure;
  String arrival;
  int seats;
  int price;
  String date;
  int idUser;
  String registrationNumber;

  RideAddModel(
    {
      required this.arrival,
      required this.departure,
      required this.date,
      required this.price,
      required this.seats,
      required this.idUser,
      required this.registrationNumber
    }
  );

  factory RideAddModel.fromMap(Map<String,dynamic>map){
    return RideAddModel(
      arrival: map["arrival"],
     departure: map["departure"] ,
      date: map["date"],
       price: map["price"],
        seats: map["seats"],
         idUser: map["idUser"],
         registrationNumber: map["registrationNumber"],
         );
  }
  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      "idUser":idUser,
      "price":price,
      "seats":seats,
      "date":date,
      "departure":departure,
      "arrival":arrival,
      "registrationNumber":registrationNumber
    };
  }
  String toJson ()=>json.encode(toMap());

}