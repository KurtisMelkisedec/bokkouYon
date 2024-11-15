import 'dart:io';

import 'package:bokkuyon/core/constante/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
  final String hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller; 
  final IconData iconInput; 
  final Color? inputColor; 
  final TextInputType? contentType;
  final FocusNode? focusNode; 
  CustomInput(
    {
      Key? key,
      required this.hintText,
      required this.iconInput,
      this.obscureText,
      required this.controller,
      this.validator,
      this.inputColor,
      this.contentType,
      this.focusNode
    }
  );
  
  @override
  Widget build(BuildContext context) {
   return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      height: 60,  
      width: 4.2 * MediaQuery.of(context).size.width /5,
      padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 6.0,
        ),
         decoration: BoxDecoration(
          color: inputColor??Colors.grey.withOpacity(0.3),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
         
    child: TextFormField(      
           controller: controller, 
           keyboardType: contentType??TextInputType.name,  
           autovalidateMode: AutovalidateMode.onUserInteraction,                  
            validator: validator,
            focusNode: focusNode??FocusNode(),
            obscureText: obscureText??false,
            decoration: InputDecoration(
              filled: false,
              border: InputBorder.none,
              prefixIcon: Icon(this.iconInput,color: Colors.black,),
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