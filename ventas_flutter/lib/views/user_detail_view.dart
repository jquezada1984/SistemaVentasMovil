import 'package:flutter/material.dart';
import '../models/user.dart';
import 'user_form_view.dart';  // Asegúrate de importar UserFormView

class UserDetailView extends StatelessWidget {
  final User user;

  UserDetailView({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormView(user: user)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
            Text('City: ${user.city}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
