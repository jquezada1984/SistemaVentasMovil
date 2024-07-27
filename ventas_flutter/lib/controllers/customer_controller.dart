import '../models/customer.dart';
import '../services/database_service.dart';

class CustomerController {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> addCustomer(Customer customer) async {
    await _databaseService.insertCustomer(customer);
  }

  Future<void> updateCustomer(Customer customer) async {
    await _databaseService.updateCustomer(customer);
  }

  Future<void> deleteCustomer(String id) async {
    await _databaseService.deleteCustomer(id);
  }

  Future<List<Customer>> getCustomers() async {
    return await _databaseService.getCustomers();
  }
}
