import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/ride_service.dart';
import 'package:flutter/material.dart';

class TripListPage extends StatefulWidget {
  static String routName="trips";
  const TripListPage({super.key});

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        centerTitle: true,
      backgroundColor: Colors.white,
      title:Text("Mes trajets",textAlign: TextAlign.center,style: TextStyle(letterSpacing: 4,color: dkDarkBlue,fontWeight: FontWeight.w700,fontSize: 25),) ,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,size: 35,)),
    ) ,
      body: ListView.builder(
        itemCount: RideService.rides!.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:15,vertical: 20),
            child: Container(
              width:  MediaQuery.of(context).size.width /5,
              decoration: BoxDecoration(
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25), 
                          spreadRadius: 2, 
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        ],
                    ),
                    height:90,
                    width: 105,
                    child: Image.asset("assets/car.png"),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      Text("${RideService.rides![index].departureId.split(",")[0]} - ${RideService.rides![index].arrivalId.split(",")[0]}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 10,),
                      Row(children: [Icon(Icons.calendar_month,color: Colors.grey,),const SizedBox(width: 4,),Text(RideService.rides![index].date,style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w600),)],),
                       const SizedBox(height: 3,),
                      Row(children: [Icon(Icons.person,color: Colors.grey,),const SizedBox(width: 4,),Text(RideService.rides![index].seats.toString(),style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w600),)],),
                      const SizedBox(height: 3,),
                       Container(
                          height: 2.0, 
                          width: 170,                              
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(7)),// Marge de chaque côté
                        )
                    ],
                  ),
                  Icon(RideService.rides![index].etat ? Icons.check_circle:Icons.access_time,color:RideService.rides![index].etat ? Colors.green.shade400:Colors.grey,)
              
                ],
              ),
            ),
          );

      }),
    );
  }
}