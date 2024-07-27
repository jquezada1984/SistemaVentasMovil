import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'views/product_list_view.dart';
import 'views/customer_list_view.dart';
import 'views/sale_view.dart';
import 'views/login_view.dart';
import 'views/tab_view.dart';
import 'views/user_form_view.dart';
import 'views/product_form_view.dart';
import 'views/customer_form_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/login': (context) => LoginView(),
        '/tab': (context) => TabView(),
        '/userList': (context) => UserListView(),
        '/productList': (context) => ProductListView(),
        '/customerList': (context) => CustomerListView(),
        '/sale': (context) => SaleView(),
        '/userForm': (context) => UserFormView(),
        '/productForm': (context) => ProductFormView(),
        '/customerForm': (context) => CustomerFormView(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userList');
              },
              child: Text('User Management'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/productList');
              },
              child: Text('Product Management'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customerList');
              },
              child: Text('Customer Management'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sale');
              },
              child: Text('Sales Management'),
            ),
          ],
        ),
      ),
    );
  }
}
