import 'package:flutter/material.dart';
import 'product_list_view.dart';
import 'registration_view.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Products'),
              Tab(icon: Icon(Icons.person_add), text: 'Register'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductListView(),
            RegistrationView(),
          ],
        ),
      ),
    );
  }
}

