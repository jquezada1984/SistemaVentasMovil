import 'package:uuid/uuid.dart';
import '../models/sale.dart';
import '../services/database_service.dart';

class SaleController {
  final DatabaseService _databaseService = DatabaseService();
  final Uuid _uuid = Uuid();

  Future<void> addSale(Sale sale) async {
    sale = Sale(
      id: _uuid.v4(),
      customer: sale.customer,
      items: sale.items,
      totalValue: sale.items.fold(
        0.0,
        (previousValue, item) => previousValue + (item.product.price * item.quantity),
      ),
    );
    await _databaseService.insertSale(sale);
  }

  Future<List<Sale>> getSales() async {
    return await _databaseService.getSales();
  }
}
