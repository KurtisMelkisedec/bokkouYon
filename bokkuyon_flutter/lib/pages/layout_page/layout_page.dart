import 'dart:ffi';

import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/ride_service.dart';
import 'package:bokkuyon/pages/driver_pages/add_page/add_ride_page.dart';
import 'package:bokkuyon/pages/trip_list_page/trip_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LayoutPage extends StatefulWidget{
  static String routeName="layout";
  const LayoutPage({super.key});
  @override
  State<StatefulWidget> createState() =>_LayoutPage();
  
}

class _LayoutPage extends State<LayoutPage>{
  int _currentIndex=0;
   List<Widget>widgets=<Widget>[
      AddRidePage(),
      TripListPage(),
      

    ];
  @override
  Widget build(BuildContext context) {
    
   
    // TODO: implement build
    return Scaffold(
       body: widgets[_currentIndex],
  bottomNavigationBar: GNav(
            padding: EdgeInsets.symmetric(vertical: 34,horizontal: 25), 
    
            color: Colors.black,
            activeColor: dkSkyBlue,
            tabBackgroundColor: dkSkyBlue.withOpacity(0.4),
            gap: 20,
            
            tabs: [
              GButton(
                padding: EdgeInsets.all(17),
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                padding: EdgeInsets.all(17),
                icon: Icons.car_repair,
                text: "Trajets ",
              ),
              GButton(
                padding: EdgeInsets.all(17),
                icon: Icons.message,
                text: "Messages",
              ),
              GButton(
                icon: Icons.menu,
                text: "Menu",
                padding: EdgeInsets.all(17),
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) async {
              if (index==1) {
                await RideService.findMyRide(); 
              }
             
              setState(() {
                _currentIndex = index;
               

              });
            })
  );


  }
  
}