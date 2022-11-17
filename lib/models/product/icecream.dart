import 'package:cloud_firestore/cloud_firestore.dart';

class Icecream {
  String? id;
  String? sabor;
  String? price;
  String? unit;
  String? image;
  bool? active; 

  Icecream(
    {
    this.id,
    this.sabor,
    this.price,
    this.image,
    this.active
  });

  Icecream.fromDocument(DocumentSnapshot doc){
    id=doc.id;
    sabor=doc.get('sabor') as String;
    price=doc.get('price') as String;
    unit=doc.get('unit') as String;
    image=doc.get('image') as String;
    active=doc.get('active') as bool; 

  }

  Map<String, dynamic> toMap(){
    return {
      'sabor': sabor,
      'price':price,
      'unit':unit,
      'image':price,
      'active': active
    };
  }
}