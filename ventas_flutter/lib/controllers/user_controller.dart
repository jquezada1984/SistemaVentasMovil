import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }
}
