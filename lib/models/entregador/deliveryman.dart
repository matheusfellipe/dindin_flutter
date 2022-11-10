import 'package:cloud_firestore/cloud_firestore.dart';

class Deliveryman {
  String? id;
  String? name;
  String? cpf;
  String? phone;
  String? route;
  

  Deliveryman(
    {
    this.id,
    this.name,
    this.cpf,
    this.phone,
    this.route
  });

  Deliveryman.fromDocument(DocumentSnapshot doc){
    id=doc.id;
    name=doc.get('name') as String;
    cpf=doc.get('cpf') as String;
    phone=doc.get('phone') as String;
    route=doc.get('route') as String;
    

  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'cpf':cpf,
      'phone':phone,
      'route':route,
    };
  }
}