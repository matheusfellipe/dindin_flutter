import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:din_din_com/models/sale/sale.dart';

class SaleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;

  SaleService() {
    firestoreRef = _firestore.collection('sales');
  }

  Future<bool> add({Sale? sale, dynamic imageFile, required bool plat}) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _uuid = const Uuid().v1();
    try {
      final doc = await firestoreRef.add(sale!.toMap()).then((value) {
        sale.id = value.id;
        firestoreRef.doc(sale.id).set(sale.toMap());
      }); //após receber o objeto do form na view eu passo ele para json e manda para o firebase salvar
      sale.id = doc.id;

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
}
