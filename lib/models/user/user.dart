import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocal {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;


UserLocal({
  this.id,
  this.name,
  this.email,
  this.password,
  this.confirmPassword,
});

UserLocal.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name') as String;
    email = doc.get('email') as String;
  
  }

Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }


}