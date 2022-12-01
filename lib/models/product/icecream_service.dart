import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:din_din_com/models/product/icecream.dart';

class IcecreamService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  FirebaseStorage storage = FirebaseStorage.instance;

  IcecreamService() {
    firestoreRef = _firestore.collection('icecreams');
  }
  Future<bool> add(
      {Icecream? icecream, dynamic imageFile, required bool plat}) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _uuid = const Uuid().v1();
    try {
      final doc = await firestoreRef.add(icecream!.toMap()).then((value) {
        icecream.id = value.id;
        firestoreRef.doc(icecream.id).set(icecream.toMap());
      }); //após receber o objeto do form na view eu passo ele para json e manda para o firebase salvar
      icecream.id = doc.id;

      Reference storageRef =
          storage.ref().child('icecreams').child(icecream.id!);
      final UploadTask task;

      if (!plat) {
        task = storageRef.child(_uuid).putFile(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'upload_by': 'Matheus',
                  'description': '${icecream.sabor}'
                },
              ),
            );
      } else {
        task = storageRef.child(_uuid).putData(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'upload_by': 'Matheus',
                  'description': '${icecream.sabor}'
                },
              ),
            );
      }

      final String url =
          await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = firestoreRef.doc(icecream.id);
      await docRef.update({'image': url});

      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> update(String icecreamId, Icecream icecreamItem) async {
    try {
      await firestoreRef.doc(icecreamItem.id).set(icecreamItem.toMap());
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'ok') {
        debugPrint('Problemas ao deletar a transação');
      } else if (e.code == 'ABORTED') {
        debugPrint('Edição abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> delete(String icecreamId) async {
    try {
      await firestoreRef.doc(icecreamId).delete();
      await storage.ref().child('icecreams').child(icecreamId).delete();
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
