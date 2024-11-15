 import 'dart:convert';

import 'package:bokkuyon/core/components/custom_form_field.dart';
import 'package:bokkuyon/core/components/custom_input.dart';
import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/models/location_model.dart';
import 'package:bokkuyon/core/models/response_form_model.dart';
import 'package:bokkuyon/core/models/ride_add_model.dart';
import 'package:bokkuyon/core/services/location_service.dart';
import 'package:bokkuyon/core/services/ride_service.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/layout_page/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:free_place_search/place_search.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddRidePage extends StatefulWidget {
  static String routeName="addRide";
  const AddRidePage({ Key? key }) : super(key: key);

  @override
  _AddRidePage createState() => _AddRidePage();
}

class _AddRidePage extends State<AddRidePage> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  dynamic departureId;
  dynamic arrivalId;
  final FocusNode _focusDepartureNode = FocusNode();
  final FocusNode _focusArrivalNode = FocusNode();
  bool isInputDepartureActive=false;
  bool isInputArrivalActive=false;
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  String token="1234567890";
  List<dynamic>locationsDepartureList =[];
  List<dynamic>locationsArrivalList =[];
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
  Future<void> _selectDate() async {
   DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),  
    lastDate: DateTime(2100),   
  );

  if (pickedDate != null) {
   setState(() {
    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate).split(" ")[0];
      _dateController.text = formattedDate;
   });      
  }
}

 void showConfirmationMessage(BuildContext context,ResponseFormModel response){
   final snackBar =SnackBar(
    content: Text(response.message??""),
    duration: Duration(seconds: 5),
    backgroundColor: response.isValid?Colors.green.shade400:Colors.red.shade400,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
   ) ;

   ScaffoldMessenger.of(context).showSnackBar(snackBar);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.white,    
      appBar: AppBar(
        centerTitle: true,
      backgroundColor: Colors.white,
      title:Text("Créer un trajet",textAlign: TextAlign.center,style: TextStyle(letterSpacing: 4,color: dkDarkBlue,fontWeight: FontWeight.w700,fontSize: 25),) ,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,size: 35,)),
    ),
    body: 
                     
             SingleChildScrollView(
               child: Center(
                 child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key:_formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  
                        Text("Votre adresse est privée",style: TextStyle(fontSize: 13.81,color: Color(0xFFBEBEBE)),),     
                        const SizedBox(height: 14,),       
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
                               print(locationsDepartureList[index]);
                               departureId=locationsDepartureList[index];
                              
                                
                                 
                              
                               
                              },
                              child: ListTile(title:Text(locationsDepartureList[index]["description"])),
                            );
                          })),
                        ),
                        const SizedBox(height: 14,),
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
                              onTap: (){
                                _arrivalController.text =locationsArrivalList[index]["description"];
                                arrivalId=locationsArrivalList[index];
                                setState(() {
                                  isInputArrivalActive=false;
                                });
                              },
                              child: ListTile(title:Text(locationsArrivalList[index]["description"])),
                            );
                          })),
                        ),
                        const SizedBox(height: 14,),
                      Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,  
                        width: 4.2 * MediaQuery.of(context).size.width /5,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 6.0,
                          ),
                           decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                            ),
                          ),
                           
                      child: TextFormField(      
                  
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                             readOnly: true,
                             controller: _dateController,
                             onTap: (){
                  _selectDate();
                             },                     
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    
                    prefixIcon: Icon(Icons.date_range,color: Colors.black,),
                    hintText: "séléctionnez la date",
                    hintStyle:  TextStyle(
                      color: dkGreyInput.withOpacity(0.6),
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  
                  ),
                      ),
                     )),  
                     const SizedBox(height: 14,),
                     CustomInput(hintText: "Nombre de places", iconInput: Icons.chair_alt, controller: _seatsController,contentType: TextInputType.number,validator: (value){
                      if (value!=null && value.isEmpty) {
                        return "Le prix est obligatoire";
                      }
                      if (value!=null && !RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                        return "Veuillez entrez un nombre valide";
                      }
                 
                     },),
                     const SizedBox(height: 14,),
                     CustomInput(hintText: "Prix (en FCFA)", iconInput: Icons.monetization_on_sharp, controller: _priceController,contentType: TextInputType.number,validator: (value){
                      if (value!=null && value.isEmpty) {
                        return "Le nombre de place est obligatoire";
                      }
                      if (value!=null && !RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                        return "Veuillez entrez un nombre valide";
                      }
                     },),
                     const SizedBox(height: 14,),
                     CustomInput(hintText: "Matricule", iconInput: Icons.car_rental_outlined, controller: _registrationNumberController,validator: (value){
                      if (value!=null && value.isEmpty) {
                        return "Le matricule est obligatoire";
                      }
                      
                     },),
                     const SizedBox(height: 20,),
                      ElevatedButton(onPressed: ()async{                     
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();  
                            RideAddModel ride= RideAddModel(arrival: 
                             arrivalId["description"],
                             departure: departureId["description"], 
                              date: _dateController.text,
                              price: int.parse(_priceController.text) , 
                              seats: int.parse(_seatsController.text), 
                              idUser: UserService.tokenResponse!.id,
                              registrationNumber: _registrationNumberController.text);
                              ResponseFormModel? response= await RideService.addRide(ride); 
                              if (response!=null) {
                                showConfirmationMessage(context,response);
                                if (response.isValid) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => LayoutPage()),
                                     );
                                }
                              }
                          } 
                            },style: ElevatedButton.styleFrom(
                  backgroundColor:  dkSemiBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  minimumSize: (Size(290, 42))
                            ), child: Text("Enregistrer",style: TextStyle(color: Colors.white,fontSize: 22.11,fontWeight: FontWeight.w600),)
                            ),     
                      
                      ],
                                ),
                    ),
                  ),
               ),
             ),
            
      
      

   
    );
  }
} 