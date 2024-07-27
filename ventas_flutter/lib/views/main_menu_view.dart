import 'package:flutter/material.dart';
import 'user_list_view.dart';
import 'product_list_view.dart';
import 'customer_list_view.dart';
import 'sale_list_view.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Añade la imagen aquí
            Image.asset(
              'assets/images/logo.png',
              height: 200, // Ajusta el tamaño de la imagen según sea necesario
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('User Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListView()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Product Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListView()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Customer Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListView()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Sales Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaleListView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
