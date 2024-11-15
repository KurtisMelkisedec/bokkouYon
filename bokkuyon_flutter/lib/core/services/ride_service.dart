import 'package:bokkuyon/core/models/response_form_model.dart';
import 'package:bokkuyon/core/models/ride_add_model.dart';
import 'package:bokkuyon/core/models/ride_list_model.dart';
import 'package:bokkuyon/core/models/ride_reservation_model.dart';
import 'package:bokkuyon/core/repositories/ride_repository.dart';

class RideService {
  static List<RideListModel>rides =[];
  static List<RideReservationModel>ridesReservation =[];
  
  static Future<ResponseFormModel?>  addRide(RideAddModel ride) async{
    return await RideRepository.addRide(ride);
  }

  static Future<List<RideListModel>?>findMyRide()async{
    final response=await RideRepository.findMyRide() ;
    rides=response!;
  }

  static Future<void>findTripsByDepartureAndArrival(String departure,String arrival)async{
    final response= await RideRepository.findTripsByDepartureAndArrival(departure, arrival);
    ridesReservation=response!;
  }
  
}