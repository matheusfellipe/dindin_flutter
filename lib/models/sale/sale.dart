// import 'package:cloud_firestore/cloud_firestore.dart';

// class Sale {
//   String? id;
//   String? vlr_total;
//   String? dt_venda;
//   String? unit;
//   String? image;
//   bool? entrega = true;

//   Sale({this.id, this.sabor, this.price, this.image, this.active});

//   Sale.fromDocument(DocumentSnapshot doc) {
//     id = doc.id;
//     sabor = doc.get('sabor') as String;
//     price = doc.get('price') as String;
//     unit = doc.get('unit') as String;
//     image = doc.get('image') as String;
//     active = doc.get('active') as bool;
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'sabor': sabor,
//       'price': price,
//       'unit': unit,
//       'image': price,
//       'active': active
//     };
//   }

//   Sale.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     sabor = map['sabor'];
//     unit = map['unit'];
//     price = map['price'];
//     image = map['image'];
//     active = map['active'];
//   }
// }
