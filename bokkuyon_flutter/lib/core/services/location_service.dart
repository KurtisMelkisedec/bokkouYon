import 'package:bokkuyon/core/repositories/location_repository.dart';

class LocationService {

  static Future<dynamic> findLocationsOnChange(String input)async{
    return await LocationRepository.findLocationsOnChange(input);
  }
  
}