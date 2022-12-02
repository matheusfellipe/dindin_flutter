// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  String? id;
  String? vlr_total;
  bool? entrega = true;
  String? dt_venda;
  String? obs;
  String? forma_pagamento;
  bool? pago = false;

  Sale(
      {this.id,
      this.vlr_total,
      this.entrega,
      this.dt_venda,
      this.forma_pagamento,
      this.pago});

  Sale.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    vlr_total = doc.get('vlr_total') as String;
    entrega = doc.get('entrega') as bool;
    dt_venda = doc.get('unit') as String;
    obs = doc.get('obs') as String;
    forma_pagamento = doc.get('forma_pagamento') as String;
    pago = doc.get('pago') as bool;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vlr_total': vlr_total,
      'entrega': entrega,
      'dt_venda': dt_venda,
      'obs': obs,
      'forma_pagamento': forma_pagamento,
      'pago': pago
    };
  }

  Sale.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    vlr_total = map['vlr_total'];
    entrega = map['entrega'];
    dt_venda = map['dt_venda'];
    obs = map['obs'];
    forma_pagamento = map['forma_pagamento'];
    pago = map['pago'];
  }
}
