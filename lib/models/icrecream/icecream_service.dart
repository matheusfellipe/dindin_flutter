

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:din_din_com/models/icrecream/icecream.dart';

class IcecreamService {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  late CollectionReference firestoreRef;

IcecreamService(){
  firestoreRef = _firestore.collection('icecreams');

}
Future<bool> add(Icecream icecream, dynamic imageFile, bool plat) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final _uuid = const Uuid().v1();

  try {
    final doc = await firestoreRef.add(icecream.toMap());
    icecream.id = doc.id;

    Reference storageRef = storage.ref().child('icecreams').child(icecream.id!);
    final UploadTask task;

    if(!plat){
      task = storageRef.child(_uuid).putFile(imageFile);
      storageRef.putFile(imageFile);
    }else {
      task = storageRef.child(_uuid).putData(imageFile);
      storageRef.putData(imageFile);
    }

    final String url = await (await task).ref.getDownloadURL();
    DocumentReference docRef = firestoreRef.doc(icecream.id);
    await docRef.update({'image':url});

    icecream.image = url;

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

Future<bool> delete(String icecreamId) async {
    try {
      await firestoreRef.doc(icecreamId).delete();
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
