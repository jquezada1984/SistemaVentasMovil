import 'package:uuid/uuid.dart';
import '../models/product.dart';
import '../services/database_service.dart';

class ProductController {
  final DatabaseService _databaseService = DatabaseService();
  final Uuid _uuid = Uuid();

  Future<void> addProduct(Product product) async {
    product = Product(
      id: _uuid.v4(),
      name: product.name,
      price: product.price,
    );
    await _databaseService.insertProduct(product);
  }

  Future<List<Product>> getProducts() async {
    return await _databaseService.getProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _databaseService.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
  }
}
