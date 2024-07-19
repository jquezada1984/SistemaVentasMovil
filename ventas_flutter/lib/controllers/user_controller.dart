import '../models/user.dart';
import '../services/database_service.dart';

class UserController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> registerUser(User user) async {
    await _databaseService.insertUser(user);
  }

  Future<List<User>> getUsers() async {
    return await _databaseService.getUsers();
  }

  Future<void> updateUser(User user) async {
    await _databaseService.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await _databaseService.deleteUser(id);
  }
}
