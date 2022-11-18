import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:din_din_com/screen/product/icrecream_add_page.dart';
import 'package:flutter/material.dart';
import 'package:din_din_com/models/product/icecream_service.dart';

class IcecreamListPage extends StatefulWidget {
  const IcecreamListPage({Key? key}) : super(key: key);

  @override
  State<IcecreamListPage> createState() => _IcecreamListPageState();
}

class _IcecreamListPageState extends State<IcecreamListPage> {
  @override
  Widget build(BuildContext context) {
    IcecreamService _icecreamService = IcecreamService();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
            stream: _icecreamService.firestoreRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificar a existência de dados
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      print(docSnapshot['image']);
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
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            // child: Image.network(cartProduct.product.images.first),
                                            child: Image.network(
                                                docSnapshot['image'] ?? " ",
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                              return const CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.cyanAccent,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
                                              );
                                            }
                                                // docSnapshot['image']
                                                ),
                                          ),
                                          Text(
                                            docSnapshot['sabor'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            docSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () async {
                                        bool ok = await _icecreamService
                                            .delete(docSnapshot.id);
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
              builder: (context) => IceCreamAddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
