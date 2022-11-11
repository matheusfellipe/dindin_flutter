import 'package:din_din_com/screen/icecream/icrecream_add_page.dart';
import 'package:flutter/material.dart';

import '../deliveryman/deliveryman_add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              // style: style,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const Scaffold(
                      body: Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
              child: const Text('Venda'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // style: style,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IceCreamAddPage(),
                  ),
                );
              },
              child: const Text('Cremosinho'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // style: style,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DeliverymanAddPage(),
                  ),
                );
              },
              child: const Text('Entregador'),
            ),
            const SizedBox(width: 50),
            ElevatedButton(
              // style: style,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const Scaffold(
                      body: Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
              child: const Text('Clientes'),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Logout')));
            },
          ),
        ],
      ),
    );
  }
}
