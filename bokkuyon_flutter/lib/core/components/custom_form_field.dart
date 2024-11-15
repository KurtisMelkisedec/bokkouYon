import 'package:bokkuyon/core/constante/colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller; 
  final IconData iconInput;
  final formKey;
  CustomFormField(
    {
      Key? key,
      required this.hintText,
      required this.iconInput,
      this.obscureText,
      required this.controller,
      this.validator,
      this.formKey
    }
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      height: 60,
      
      width: 4.4 * MediaQuery.of(context).size.width /5,
      padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 6.0,
        ),
         
    child: TextFormField(

           controller: controller,
           
           onTapOutside: (value){
           if (formKey.currentState != null) {
                formKey.currentState!.validate();
              }
           },
           
            validator: validator,
            obscureText: obscureText??false,
            decoration: InputDecoration(
              filled: false,
              enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dkGreyInput), // Couleur de bordure en bas (grise)
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dkGreyInput), // Couleur de bordure quand on clique
    ),
              prefixIcon: Icon(this.iconInput,color: dkGreyInput.withOpacity(0.6),),
              hintText: hintText,
              hintStyle:  TextStyle(
                color: dkGreyInput.withOpacity(0.6),
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
    ),
   ));
  }
  
}