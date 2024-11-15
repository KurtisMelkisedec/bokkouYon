import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/pages/slider_page/slider_page.dart';
import 'package:bokkuyon/pages/swipper_home/swipper_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  static String routName = "/home";

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: Container(
      color:  dkSkyBlueTransparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap:(){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  SwipperHome()));
              } ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/loading_page.png"),
                  SizedBox(height: 10,),
                  Text("BokkouYon",
                  style: const TextStyle(fontSize:52 ,
                                        color: dkSkyBlue,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 4,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dkSkyBlue),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    ),
   );
  }

}