import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    QuerySnapshot result = await _firestore.collection('products').get();
    return result.docs.map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
