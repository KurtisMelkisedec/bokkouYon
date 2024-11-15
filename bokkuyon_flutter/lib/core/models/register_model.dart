import 'dart:convert';

class RegisterModel {
  String fullname;
  String password;
  String phone;
  String email;

  RegisterModel({
    required this.fullname,
    required this.password,
    required this.phone,
    required this.email
  });

  factory RegisterModel.fromMap(Map<String,dynamic>map){
    return RegisterModel(fullname: map["fullname"], password: map["password"], phone: map["phone"],email: map["email"]);
  }

  Map<String,dynamic>toMap(){
    return <String,dynamic>{"fullname":fullname,"password":password,"phone":phone,"email":email};
  }

  String toJson()=>json.encode(toMap());

  
}