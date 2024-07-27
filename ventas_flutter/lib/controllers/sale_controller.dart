import '../models/sale.dart';
import '../services/database_service.dart';

class SaleController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addSale(Sale sale) async {
    await _databaseService.insertSale(sale);
  }

  Future<void> updateSale(Sale sale) async {
    await _databaseService.updateSale(sale);
  }

  Future<void> deleteSale(String id) async {
    await _databaseService.deleteSale(id);
  }

  Future<List<Sale>> getSales() async {
    return await _databaseService.getSales();
  }
}
