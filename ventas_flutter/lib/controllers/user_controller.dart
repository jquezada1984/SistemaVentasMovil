import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart';
import '../services/database_service.dart';

class UserController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> registerUser(User user) async {
    user = User(
      id: user.id,
      name: user.name,
      email: user.email,
      address: user.address,
      phone: user.phone,
      city: user.city,
      password: _hashPassword(user.password), // Encriptar la contraseña
    );
    await _databaseService.insertUser(user);
  }

  Future<List<User>> getUsers() async {
    return await _databaseService.getUsers();
  }

  Future<void> updateUser(User user) async {
    user = User(
      id: user.id,
      name: user.name,
      email: user.email,
      address: user.address,
      phone: user.phone,
      city: user.city,
      password: _hashPassword(user.password), // Encriptar la contraseña
    );
    await _databaseService.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await _databaseService.deleteUser(id);
  }

  Future<User?> authenticateUser(String email, String password) async {
    User? user = await _databaseService.getUserByEmail(email);
    if (user != null && user.password == _hashPassword(password)) {
      return user;
    } else {
      return null;
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
