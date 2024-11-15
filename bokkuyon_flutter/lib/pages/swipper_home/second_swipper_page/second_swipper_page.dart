import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/pages/home_page/home_page.dart';
import 'package:bokkuyon/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';

class SecondSwipperPage extends StatelessWidget {
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
          Image.asset("assets/sign-2.png"),
          const SizedBox(height: 20,),
          Text("Suivi en temps réel",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: dkDarkBlue),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Text("Suivez l’emplacement de votre chauffeur sur la carte", textAlign: TextAlign.center,style: TextStyle(fontSize: 22.11,fontWeight: FontWeight.w600,color: dkGrey),),
          ),
          const SizedBox(height: 50,),
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
                backgroundColor: dkSkyBlue,
              ),
               const SizedBox(width: 20,),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 14,),
          TextButton(onPressed: (){
                        Navigator.pushNamed(context, RegisterPage.routName);

          }, child: Text("skip",style: TextStyle(fontSize: 22.11, color: dkLightGrey,fontWeight: FontWeight.w600),))

        ],
      ),
    );
  }
  
}