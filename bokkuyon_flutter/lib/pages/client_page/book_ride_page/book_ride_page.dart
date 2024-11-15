import 'package:bokkuyon/core/components/custom_input.dart';
import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/services/location_service.dart';
import 'package:bokkuyon/core/services/ride_service.dart';
import 'package:flutter/material.dart';

class BookRidePage extends StatefulWidget {
  static String routeName="bookRide";
  const BookRidePage({super.key});

  @override
  State<BookRidePage> createState() => _BookRidePage();
}

class _BookRidePage extends State<BookRidePage> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final FocusNode _focusDepartureNode = FocusNode();
  final FocusNode _focusArrivalNode = FocusNode();
  List<dynamic>locationsDepartureList =[];
  List<dynamic>locationsArrivalList =[];
  String departureId="";
  String arrivalId="";
   bool isInputDepartureActive=false;
  bool isInputArrivalActive=false;
  bool toggleInput =true;

  @override
  void initState() {
     _departureController.addListener((){
      toggleInput=true;
      _onChange(_departureController.text);

    });
    _arrivalController.addListener((){
      toggleInput=false;
      _onChange(_arrivalController.text);

    });
    _focusDepartureNode.addListener(() {
      if (!_focusDepartureNode.hasFocus) {
        isInputDepartureActive =false;
        
      }
    });
    _focusArrivalNode.addListener(() {
      if (!_focusArrivalNode.hasFocus) {
        isInputArrivalActive =false;
        
      }
    });
    // TODO: implement initState
    super.initState();
  }
  _onChange(String inputValue){
    placeSuggestion(inputValue,toggleInput);
  }

  void placeSuggestion(String input,bool toggle) async{
     
      dynamic response = await LocationService.findLocationsOnChange(input);
     
      if (response!=null) {
        setState(() {
          if (toggle) {
                 locationsDepartureList =response;    
                 isInputDepartureActive=true;
          }
          else{
            locationsArrivalList =response; 
            isInputArrivalActive=true; 

          }
                      
        });
      }
      
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
      backgroundColor: Colors.white,
      title:Text("Créer un trajet",textAlign: TextAlign.center,style: TextStyle(letterSpacing: 4,color: dkDarkBlue,fontWeight: FontWeight.w700,fontSize: 25),) ,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,size: 35,)),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomInput(focusNode: _focusDepartureNode,hintText: "Départ", iconInput: Icons.location_on, controller: _departureController,
                        validator: (value){
                          if (value!=null && value.isEmpty) {
                            return "Le lieu de départ est obligatoire";
                          }
                 
                        },),                      
                        Visibility(
                          visible: (isInputDepartureActive && !_departureController.text.isEmpty)?true:false,
                          
                          child: Flexible(child: ListView.builder(
                            shrinkWrap: true, 
                            physics: ClampingScrollPhysics(),                      
                            itemCount:locationsDepartureList.length,
                            itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){                        
                               _departureController.text=locationsDepartureList[index]["description"];
                               departureId=locationsDepartureList[index]["description"]; 
                              },
                              child: ListTile(title:Text(locationsDepartureList[index]["description"])),
                            );
                          })),
                        ),
                        CustomInput(focusNode: _focusArrivalNode,hintText: "Arrivé", iconInput: Icons.location_on_outlined, controller: _arrivalController,
                        validator: (value){
                           if (value!=null && value.isEmpty) {
                            return "Le lieu de départ est obligatoire";
                          }
                 
                        },),  
                        Visibility(
                          
                          visible: (isInputArrivalActive&& !_arrivalController.text.isEmpty)?true:false,
                          
                          child: Flexible(child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:locationsArrivalList.length,
                            itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () async{
                                _arrivalController.text =locationsArrivalList[index]["description"];
                                arrivalId=locationsArrivalList[index]["description"];
                                if(departureId!=""){
                                  await RideService.findTripsByDepartureAndArrival(departureId, arrivalId);
                                }
                                setState(() {
                                  isInputArrivalActive=false;
                                });
                              },
                              child: ListTile(title:Text(locationsArrivalList[index]["description"])),
                            );
                          })),
                        ),
                        const SizedBox(height: 10,)
                        ,
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                          icon: Icon(Icons.bookmark_border_outlined,
                              color: Colors.grey),
                          label: Text('Par défaut',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 74, 115, 218),
                          ),
                          icon: Icon(Icons.map, color: Colors.white),
                          label: Text('Carte',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 246, 247, 252), 
                  borderRadius: BorderRadius.circular(40), 
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 6, 
                        width: 70, 
                        decoration: BoxDecoration(
                          color: Colors.grey, 
                          borderRadius:
                              BorderRadius.circular(2), 
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          itemCount: RideService.ridesReservation.length,
                          itemBuilder: (context, index) {
                            return Padding(
            padding: const EdgeInsets.symmetric(horizontal:20,vertical: 20),
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
                      const SizedBox(height: 10,),
                      Row(children: [Text("${RideService.ridesReservation[index].arrival.split(" ")[0]}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),const SizedBox(width: 10,),Text("${RideService.ridesReservation[index].price} FCFA",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,)],),
                       const SizedBox(height: 3,),
                      Row(children: [Icon(Icons.access_time,color: Colors.grey,),const SizedBox(width: 14,),Text("10 min",style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w600),),Icon(Icons.person,color: Colors.grey,),const SizedBox(width: 4,),Text("${RideService.ridesReservation[index].seats}",style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w600),)],),
                      const SizedBox(height: 3,),
                       Container(
                          height: 2.0, 
                          width: 170,                              
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5),borderRadius: BorderRadius.circular(7)),// Marge de chaque côté
                        )
                    ],
                  ),
                 
              
                ],
              ),
            ),
          );
                          },
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
              Navigator.pushNamed(context, BookRidePage.routeName);
            
            },style: ElevatedButton.styleFrom(
              backgroundColor:  dkSemiBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minimumSize: (Size(240, 42))
            ), child: Text("choisir trajet",style: TextStyle(color: Colors.white,fontSize: 20.11,fontWeight: FontWeight.w400),)
            ),
                    ],
                  ),
                ),
              ),
            )
                  

      ],
    ),
    );
  }
}