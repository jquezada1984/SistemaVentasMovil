import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import 'user_detail_view.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final UserController _userController = UserController();
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = _userController.getUsers();
  }

  void _refreshUsers() {
    setState(() {
      _users = _userController.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _userController.deleteUser(user.id);
                      _refreshUsers();
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/userDetail',
                      arguments: user,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}


