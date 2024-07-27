import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'views/product_list_view.dart';
import 'views/customer_list_view.dart';
import 'views/sale_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
    );
  }
}

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
            ElevatedButton(
              child: Text('Product Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListView()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Customer Management'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListView()),
                );
              },
            ),
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
