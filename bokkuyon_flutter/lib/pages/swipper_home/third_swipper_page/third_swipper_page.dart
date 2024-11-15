import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/pages/active_location_page/active_location_page.dart';
import 'package:bokkuyon/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class ThirdSwipperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, HomePage.routName);
        }, icon: Icon(Icons.arrow_back,size: 35,)),
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/sign-3.png"),
          Text("Gagner de l’argent",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: dkDarkBlue),),
          const SizedBox(height: 17,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Text("Amener des gens lors de vos trajet et gagner de l’argent", textAlign: TextAlign.center,style: TextStyle(fontSize: 22.11,fontWeight: FontWeight.w600,color: dkGrey),),
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 20,),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
              ),
               const SizedBox(width: 20,),
              CircleAvatar(
                radius: 8,
                backgroundColor: dkSkyBlue,
              ),
            ],
          ),
          const SizedBox(height: 18,),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, ActiveLocationPage.routName);
          },style: ElevatedButton.styleFrom(
            backgroundColor: dkSemiBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            minimumSize: (Size(281, 42))
          ), child: Text("Commençons",style: TextStyle(color: Colors.white,fontSize: 22.11,fontWeight: FontWeight.w600),))

        ],
      ),
    );
  }
  
}