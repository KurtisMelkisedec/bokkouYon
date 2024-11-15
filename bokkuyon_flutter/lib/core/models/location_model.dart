import 'dart:convert';

class LocationModel{
  
  String departure;
  String arrival;
  String date;
  int idClient;

  LocationModel({
    required this.departure,
    required this.arrival,
    required this.date,
    required this.idClient,

  });

  factory LocationModel.fromMap(Map<String,dynamic>map){
    return LocationModel(date: map["date"],
     idClient: map["idClient"], 
     departure: map["departure"],
     arrival: map["arrival"],
     );
  }

  Map<String,dynamic>toMap(){
    return <String,dynamic>{
      "idClient":idClient,
      "departure":departure,
      "arrival":arrival,
      "date":date
    };
  }

  String toJson()=>json.encode(toMap());
}