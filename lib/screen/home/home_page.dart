import 'package:flutter/material.dart';
import 'package:din_din_com/screen/sale/sale_list_page.dart';
import '../deliveryman/deliveryman_list_page.dart';
import '../product/icrecream_list_page.dart';

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
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            TextButton(
              // style: style,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const SaleListPage(),
                    ));
              },
              child: const Text('Venda', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 50),
            TextButton(
              // style: style,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IcecreamListPage(),
                  ),
                );
              },
              child: const Text('Cremosinho',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 50),
            TextButton(
              // style: style,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DeliverymanListPage(),
                  ),
                );
              },
              child: const Text('Entregador',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 50),
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
