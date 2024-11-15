import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActiveLocationPage extends StatelessWidget {
  static String routName ="activeLocation";


  Future<Position> _getCurrentLocation () async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Le service de localisation est désactivé");
    }

    LocationPermission permission =await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
                     return Future.error("Permission d'obtenir la localisation refusé");     

       }
    }

    if (permission == LocationPermission.deniedForever) {
         return Future.error("Permission d'obtenir la localisation refusé définitivement");     
    }
    return await Geolocator.getCurrentPosition();

  } 

  @override
  Widget build(BuildContext context) {
    String lat;
    String long;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,size: 35) ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/sign-4.png"),
          const SizedBox(height: 20,),
          Text("Activer votre geolocalisation",textAlign: TextAlign.center,style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: dkDarkBlue),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Activez votre geolocalisation pour trouver des voitures autour de vous.", textAlign: TextAlign.center,style: TextStyle(fontSize: 20.11,fontWeight: FontWeight.w600,color: dkGrey),),
          ),
          
          const SizedBox(height: 50,),
           ElevatedButton(onPressed: (){
            _getCurrentLocation ().then((value){
              
              UserService.position =LatLng(value.latitude, value.longitude);
               Navigator.pushNamed(context, RegisterPage.routName);
             
            });
           
          },style: ElevatedButton.styleFrom(
            backgroundColor: dkSemiBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            minimumSize: (Size(281, 42))
          ), child: Text("Activer",style: TextStyle(color: Colors.white,fontSize: 22.11,fontWeight: FontWeight.w600),)),
          const SizedBox(height: 20,), 
          TextButton(onPressed: (){
            Navigator.pushNamed(context, RegisterPage.routName);
          }, child: Text("Sauter cette etape",style: TextStyle(fontSize: 22.11, color: dkLightGrey,fontWeight: FontWeight.w600),)),
          

        ],
      )
       
    );
  }
  
}