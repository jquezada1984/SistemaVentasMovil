import 'package:flutter/material.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';

class UserDetailView extends StatelessWidget {
  final User user;

  UserDetailView({required this.user});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: user.name);
    final _emailController = TextEditingController(text: user.email);
    final _addressController = TextEditingController(text: user.address);
    final _phoneController = TextEditingController(text: user.phone);
    final _cityController = TextEditingController(text: user.city);
    final _passwordController = TextEditingController(text: user.password);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save user details
                    final updatedUser = User(
                      id: user.id,
                      name: _nameController.text,
                      email: _emailController.text,
                      address: _addressController.text,
                      phone: _phoneController.text,
                      city: _cityController.text,
                      password: _passwordController.text,
                    );
                    final UserController _userController = UserController();
                    _userController.updateUser(updatedUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
