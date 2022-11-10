import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:din_din_com/models/entregador/deliveryman.dart';

class DeliverymanService {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // FirebaseStorage storage = FirebaseStorage.instance;
  late CollectionReference firestoreRef;

DeliverymanService(){
  firestoreRef = _firestore.collection('deliveryman');

}
Future<bool> add(Deliveryman deliveryman) async {
  // ignore: no_leading_underscores_for_local_identifiers

  try {
    final doc = await firestoreRef.add(deliveryman.toMap()); //após receber o objeto do form na view eu passo ele para json e manda para o firebase salvar
    deliveryman.id = doc.id;
    return Future.value(true);
  } on FirebaseException catch (e) {
    if (e.code != 'OK'){
      debugPrint('Problemas ao gravar dados');
    } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
  }
}

Future<bool> delete(String deliverymanId) async {
    try {
      await firestoreRef.doc(deliverymanId).delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao deletar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Deleção abortada');
      }
      return Future.value(false);
    }
  }


}
