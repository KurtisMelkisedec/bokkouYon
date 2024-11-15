import 'dart:convert';

import 'package:bokkuyon/core/models/location_model.dart';

class RideListModel {
  int id;
  String departureId;
  String arrivalId;
  String date;
  int seats;
  bool etat;
 

  RideListModel(
    {
      required this.id,
      required this.departureId,
      required this.arrivalId,
      required this.date,
      required this.seats,
      required this.etat,
    }
  );

  factory RideListModel.fromMap(Map<String,dynamic>map){
    return RideListModel(id: map["id"], 
    departureId: map["departureId"] , 
    arrivalId:map["arrivalId"],
     date: map["date"],
    seats: map["seats"], 
    etat: map["etat"]);
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":id,
      "departureId":departureId,
      "arrivalId":arrivalId,
      "date":date,
      "seats":seats,
      "etat":etat
    };
  }
    String toJson ()=>json.encode(toMap()); 
}