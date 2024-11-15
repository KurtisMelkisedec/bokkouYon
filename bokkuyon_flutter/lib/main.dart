import 'package:bokkuyon/pages/active_location_page/active_location_page.dart';
import 'package:bokkuyon/pages/choice_role_page/choice_role_page.dart';
import 'package:bokkuyon/pages/client_page/book_ride_page/book_ride_page.dart';
import 'package:bokkuyon/pages/client_page/home_client/home_client_page.dart';
import 'package:bokkuyon/pages/driver_pages/add_page/add_ride_page.dart';
import 'package:bokkuyon/pages/home_page/home_page.dart';
import 'package:bokkuyon/pages/layout_page/layout_page.dart';
import 'package:bokkuyon/pages/login_page/login_page.dart';
import 'package:bokkuyon/pages/register_page/register_page.dart';
import 'package:bokkuyon/pages/trip_list_page/trip_list_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      initialRoute: "",
      routes: {
        '': (context) => HomePage(),         
        'activeLocation': (context) => ActiveLocationPage(),
        'register':(context)=>RegisterPage(),
        'login':(context)=>LoginPage(),
        'choiceRole':(context)=>ChoiceRolePage(),        
        'layout':(context)=>LayoutPage(),
        'homeClient':(context)=>HomeClientPage(),
        'bookRide':(context)=>BookRidePage(),
        
        
      },
      home: HomePage(),
    );
  }

  
}


