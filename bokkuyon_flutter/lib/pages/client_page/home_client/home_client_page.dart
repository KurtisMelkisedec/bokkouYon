import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/ride_service.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/client_page/book_ride_page/book_ride_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeClientPage extends StatefulWidget{
  static String routeName="homeClient";

  @override
  State<StatefulWidget> createState() => _HomeClientPage();

}

class _HomeClientPage extends State<HomeClientPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
 appBar:AppBar(
        centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back,size: 35,)),
    ), 
    body:  GoogleMap(initialCameraPosition: CameraPosition(target:LatLng(14.746313, -17.460847),zoom: 14)),
    floatingActionButton: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: ElevatedButton(onPressed: ()async{
              Navigator.pushNamed(context, BookRidePage.routeName);            
            },style: ElevatedButton.styleFrom(
              backgroundColor:  dkSemiBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minimumSize: (Size(240, 42))
            ), child: Text("choisir trajet",style: TextStyle(color: Colors.white,fontSize: 20.11,fontWeight: FontWeight.w400),)
            ),
    ),
    );
  }
  
}