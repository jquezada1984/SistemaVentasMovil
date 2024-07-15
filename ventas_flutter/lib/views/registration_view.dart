import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'Cédula'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre completo'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = User(
                  id: _idController.text,
                  name: _nameController.text,
                  address: _addressController.text,
                  phone: _phoneController.text,
                  city: _cityController.text,
                );
                await _userController.registerUser(user);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User registered successfully')),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
