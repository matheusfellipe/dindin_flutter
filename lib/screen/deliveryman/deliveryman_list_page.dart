// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:din_din_com/models/entregador/deliveryman.dart';
import 'package:din_din_com/models/entregador/deliveryman_service.dart';
import 'package:din_din_com/screen/deliveryman/deliveryman_add_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliverymanListPage extends StatefulWidget {
  const DeliverymanListPage({Key? key}) : super(key: key);

  @override
  State<DeliverymanListPage> createState() => _DeliverymanListPageState();
}

class _DeliverymanListPageState extends State<DeliverymanListPage> {
  @override
  Widget build(BuildContext context) {
    DeliverymanService _deliverymanService = DeliverymanService();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
            stream: _deliverymanService.firestoreRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificar a existência de dados
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      Deliveryman deliveryman = Deliveryman(
                          id: docSnapshot.id,
                          name: docSnapshot['name'],
                          cpf: docSnapshot['cpf'],
                          phone: docSnapshot['phone'],
                          route: docSnapshot['route']);
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 10,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 216,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            docSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            docSnapshot['cpf'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DeliverymanAddPage(
                                              id: deliveryman.id,
                                              name: deliveryman.name,
                                              cpf: deliveryman.cpf,
                                              phone: deliveryman.phone,
                                              route: deliveryman.route,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () async {
                                        print(deliveryman.id!);
                                        bool ok = await _deliverymanService
                                            .delete(deliveryman.id!);
                                        if (ok) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Produto deletado com sucesso.'),
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'Dados indisponíveis no momento',
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DeliverymanAddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
