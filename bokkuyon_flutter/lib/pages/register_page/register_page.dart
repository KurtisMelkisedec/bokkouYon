import 'package:bokkuyon/core/components/custom_form_field.dart';
import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/models/register_model.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/home_page/home_page.dart';
import 'package:bokkuyon/pages/login_page/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static String routName ="register";
  @override
  State<StatefulWidget> createState() => _RegisterPage();
  
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage="" ;

   @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void _scrollToTop() {
    _scrollController.animateTo(
      10.0, 
      duration: Duration(seconds: 1), 
      curve: Curves.easeInOut, 
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,size: 35,)),
    ),
    body:SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Image.asset("assets/sign-in.png"),
        const SizedBox(height: 10,),
        Text("S'inscrire",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: dkDarkBlue),),
        Container(
        height: 5.0,                 // Hauteur de la ligne (épaisseur)
              // Couleur de la ligne
        margin: EdgeInsets.symmetric(horizontal:165.0), 
        decoration: BoxDecoration(color: dkSemiBlue.withOpacity(0.7),borderRadius: BorderRadius.circular(7)),// Marge de chaque côté
      ),
      const SizedBox(height: 27,),
       Text(errorMessage,style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.w600),),
      const SizedBox(height: 10,),
      Form(
        key: _formKey,
        child: Column(
        children: [
      CustomFormField(formKey: _formKey,controller: _nameController,hintText: "Veuillez entre votre nom complet",iconInput: Icons.person,
      validator:(value){
        
        if (value!=null && value.isEmpty) {
          return "Le nom est obligatoire";
        }

      } ,),
            const SizedBox(height: 5,),

      CustomFormField(formKey: _formKey,controller: _emailController,hintText: "Veuillez entre votre adresse mail",iconInput: Icons.mail,
      validator:(value){
       
        if (value!=null && value.isEmpty) {
          return "L'email est obligatoire";
        }
        if (value!=null && !RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
          return "L'email doit etre valide";
        }

      } ,),
      const SizedBox(height: 5,),
      CustomFormField(formKey: _formKey,controller:_phoneController ,hintText: "Veuillez entre votre numéro de téléphone",iconInput: Icons.phone
      ,validator: (value){
        if (value!=null && value.isEmpty) {
          return "Le numéro est obligatoire";
        }
        if (value!=null && !RegExp(r"^(77|78|76|70)\d{7}$").hasMatch(value)) {
           return "Le numéro doit etre valide";
        }
        

      },),
            const SizedBox(height: 5,),

      CustomFormField(formKey: _formKey,controller:_passwordController , hintText: "Veuillez entre votre mot de passe",iconInput: Icons.password,obscureText: true,
      validator: (value){
        if (value!=null && value.isEmpty) {
          return "Le mot de passe est obligatoire";
        }
        if (value!=null && value.length<4) {
          return "Le mot de passe doit contenir au moins 4 caractères";
        }

      },
      ),
            const SizedBox(height: 5,),

      CustomFormField(formKey: _formKey,controller: _confirmPasswordController,hintText: "Confirmez votre mot de passe",iconInput: Icons.password,obscureText: true,
      validator: (value){
        if (value!=null && value.isEmpty) {
          return "Le confirme mot de passe est obligatoire";
        }
        if (value!=null && value!=_passwordController.text ) {
          return "Le confirme mot de passe doit etre identique au mot de passe";
        }
      },
      ),
      const SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RichText(text: TextSpan(
          text: "En vous inscrivant, vous acceptez nos ",
          style: TextStyle(color:dkBlack,fontSize: 14 ,fontWeight: FontWeight.w700),
          children: [
            TextSpan(text: "conditions générales ",style: TextStyle(color: dkSemiBlue,fontSize: 14,fontWeight: FontWeight.w700)),
            TextSpan(text: "et",style: TextStyle(color: dkBlack,fontSize: 14,fontWeight: FontWeight.w700)),
            TextSpan(text: " politique de confidentialité",style: TextStyle(color: dkSemiBlue,fontSize: 14,fontWeight: FontWeight.w700)),
          ]
        ),
        textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 30,),
       ElevatedButton(onPressed: ()async{
        
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          RegisterModel user = RegisterModel(fullname: _nameController.text, password: _passwordController.text, phone: _phoneController.text,email: _emailController.text);
          dynamic value = await UserService.registerUser(user);
          if (UserService.isLogged !=null) {
            if (UserService.isLogged! ) {
               Navigator.pushNamed(context, LoginPage.routName);
              
            }
            else{
              setState(() {
                 errorMessage="Votre email/numéro est déjà utilisé";
                 _scrollToTop();
                
              });
             
            }
           
          }
         
          
          
        }else{
          print("invalide");
        }
            
           
          },style: ElevatedButton.styleFrom(
            backgroundColor:  dkSemiBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            minimumSize: (Size(290, 42))
          ), child: Text("S'inscrire",style: TextStyle(color: Colors.white,fontSize: 22.11,fontWeight: FontWeight.w600),)
          ),
         const SizedBox(height: 30,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 14),
           child: RichText(text: TextSpan(text: "vous êtes déjà inscrit ? ",
            style: TextStyle(color:dkBlack,fontSize: 14 ,fontWeight: FontWeight.w700),
            children: [
              TextSpan( text: "Connectez-vous ",style: TextStyle(color: dkSemiBlue,fontSize: 14,fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()
              ..onTap=(){
                 Navigator.pushNamed(context, LoginPage.routName);
              })
           
            ]
           )),
         ),

        ],
      )),
      
      
         const SizedBox(height: 30,)


      

      
      
      
      
       ],
      ),
    ) ,

   );}
  
}