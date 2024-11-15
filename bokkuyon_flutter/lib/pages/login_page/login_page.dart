import 'package:bokkuyon/core/components/custom_form_field.dart';
import 'package:bokkuyon/core/constante/colors.dart';
import 'package:bokkuyon/core/models/login_model.dart';
import 'package:bokkuyon/core/services/user_service.dart';
import 'package:bokkuyon/pages/choice_role_page/choice_role_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String routName="login"; 
  @override
  State<StatefulWidget> createState() =>_LoginPage();
  
  
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String errorMessage ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: (){
         Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,size: 35,)),
    ),
      body: SingleChildScrollView(
        
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/se-connect.png'),
            const SizedBox(height: 10,),
            Text("Se connecter",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: dkDarkBlue),),
        Container(
        height: 5.0,                               
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
            CustomFormField(formKey: _formKey,hintText: "Entrez votre email", iconInput: Icons.mail, controller: _loginController,
            validator:(value){
                if (value!=null && value.isEmpty) {
                  return "L'email est obligatoire";
                }
                if (value!=null && !RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  return "L'email doit etre valide";
                }

      }),
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
      const SizedBox(height: 10,),
      TextButton(onPressed: (){}, child: Text("Mot de passe oublié ?",textAlign: TextAlign.start,style: TextStyle(color: dkSemiBlue,fontSize: 12,fontWeight: FontWeight.w700),)),
      ElevatedButton(onPressed: ()async{
        
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();  
          LoginModel loginModel =LoginModel(username: _loginController.text, password: _passwordController.text);
          await UserService.login(loginModel);   
          
          if (UserService.tokenResponse !=null) {
            Navigator.pushNamed(context, ChoiceRolePage.routName);        
          }
          else{
            
             setState(() {
                 errorMessage="Email/mot de passe incorecte.s";
              });
            
           
          }
             
        } 
          },style: ElevatedButton.styleFrom(
            backgroundColor:  dkSemiBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            minimumSize: (Size(290, 42))
          ), child: Text("Se connecter",style: TextStyle(color: Colors.white,fontSize: 22.11,fontWeight: FontWeight.w600),)
          ),
          const SizedBox(height: 40,),

          ],
        ))
          ],
        ),
      ),
    );
  
  }
  
}