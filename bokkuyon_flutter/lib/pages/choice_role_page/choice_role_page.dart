import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/client_page/home_client/home_client_page.dart';
import 'package:bokkuyon/pages/driver_pages/add_page/add_ride_page.dart';
import 'package:bokkuyon/pages/layout_page/layout_page.dart';
import 'package:flutter/material.dart';

class ChoiceRolePage extends StatelessWidget {
  static String routName ="choiceRole";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3,
      ),
      body: 
     Stack(

          children: [
            Positioned.fill(child: ColorFiltered(
              colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken) ,
              child: Image.asset("assets/map.png",
            fit: BoxFit.cover)),
            ),
            Column(
            children: [
               const SizedBox(height: 30,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Choisir", style: TextStyle(fontSize: 36,fontWeight: FontWeight.w600, color: dkDarkBlue,),textAlign: TextAlign.start,),
              
             Container(       
          height: 5.0,                               
          width: 80.0,
          margin: EdgeInsets.only(top: 70,right: 20),
          decoration: BoxDecoration(color: dkSemiBlue.withOpacity(0.7),borderRadius: BorderRadius.circular(7)),// Marge de chaque côté
                ),
                ],
               ),
               const SizedBox(height: 60,),
               GestureDetector(
                onTap: (){
                  UserService.tokenResponse!.activeRole=true;
                  Navigator.pushNamed(context, LayoutPage.routeName);
                },
                 child: Container(
                 
                  decoration: BoxDecoration(
                     color: dkBlueDriver,
                    borderRadius: BorderRadius.circular(52)
                  ),
                  width: 300,
                  height: 240,
                  child: Column(
                    children: [
                      Image.asset("assets/driver-role.png"),
                      Text("Conducteur", style: TextStyle(color: dkDarkBlue,letterSpacing: 4,fontSize: 28, fontWeight: FontWeight.w500),)
                    ],
                 
                  ),
                 ),
               ),
               const SizedBox(height: 20,),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFC5ECF4),
                  borderRadius: BorderRadius.circular(90)
                ),
                width: 45,
                height: 50,
                child: Text("Ou",style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17,fontWeight: FontWeight.w500),),
               ),
               const SizedBox(height: 20,),
               GestureDetector(
                onTap: (){
                        UserService.tokenResponse!.activeRole=false;
                        Navigator.pushNamed(context, HomeClientPage.routeName);

                },
                 child: Container(
                 
                  decoration: BoxDecoration(
                     color: dkPurpleClient,
                    borderRadius: BorderRadius.circular(52)
                  ),
                  width: 300,
                  height: 240,
                  child: Column(
                    children: [
                      Image.asset("assets/client-role.png"),
                      Text("Passager", style: TextStyle(color: dkDarkBlue,letterSpacing: 4,fontSize: 28, fontWeight: FontWeight.w500),)
                    ],
                 
                  ),
                 ),
               ),

             
            ],
          ),]
        ),
      
      
    );
  }
  
}