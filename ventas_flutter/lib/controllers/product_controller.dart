import '../models/product.dart';
import '../services/database_service.dart';

class ProductController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addProduct(Product product) async {
    await _databaseService.insertProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    await _databaseService.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    await _databaseService.deleteProduct(id);
  }

  Future<List<Product>> getProducts() async {
    return await _databaseService.getProducts();
  }
}
