import 'package:flutter/material.dart';
import '../controllers/sale_controller.dart';
import '../controllers/customer_controller.dart';
import '../controllers/product_controller.dart';
import '../models/sale.dart';
import '../models/customer.dart';
import '../models/product.dart';

class SaleView extends StatefulWidget {
  @override
  _SaleViewState createState() => _SaleViewState();
}

class _SaleViewState extends State<SaleView> {
  final SaleController _saleController = SaleController();
  final CustomerController _customerController = CustomerController();
  final ProductController _productController = ProductController();

  List<Customer> _customers = [];
  List<Product> _products = [];
  List<SaleItem> _saleItems = [];

  Customer? _selectedCustomer;
  double _totalValue = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _loadProducts();
  }

  void _loadCustomers() async {
    final customers = await _customerController.getCustomers();
    setState(() {
      _customers = customers;
    });
  }

  void _loadProducts() async {
    final products = await _productController.getProducts();
    setState(() {
      _products = products;
    });
  }

  void _addProductToSale(Product product) {
    setState(() {
      final existingItem = _saleItems.firstWhere(
        (item) => item.product.id == product.id,
        orElse: () => SaleItem(product: product, quantity: 0),
      );

      if (_saleItems.contains(existingItem)) {
        existingItem.quantity++;
      } else {
        existingItem.quantity++;
        _saleItems.add(existingItem);
      }

      _totalValue = _saleItems.fold(
        0.0,
        (previousValue, item) => previousValue + (item.product.price * item.quantity),
      );
    });
  }

  void _removeProductFromSale(SaleItem saleItem) {
    setState(() {
      _saleItems.remove(saleItem);
      _totalValue = _saleItems.fold(
        0.0,
        (previousValue, item) => previousValue + (item.product.price * item.quantity),
      );
    });
  }

  void _saveSale() async {
    if (_selectedCustomer != null && _saleItems.isNotEmpty) {
      final sale = Sale(
        id: '',
        customer: _selectedCustomer!,
        items: _saleItems,
        totalValue: _totalValue,
      );

      await _saleController.addSale(sale);
      // Clear the sale data
      setState(() {
        _saleItems.clear();
        _totalValue = 0.0;
        _selectedCustomer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Sale')),
      body: Column(
        children: [
          DropdownButtonFormField<Customer>(
            decoration: InputDecoration(labelText: 'Select Customer'),
            items: _customers.map((customer) {
              return DropdownMenuItem<Customer>(
                value: customer,
                child: Text(customer.name),
              );
            }).toList(),
            onChanged: (customer) {
              setState(() {
                _selectedCustomer = customer;
              });
            },
            value: _selectedCustomer,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: () => _addProductToSale(product),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _saleItems.length,
              itemBuilder: (context, index) {
                final saleItem = _saleItems[index];
                return ListTile(
                  title: Text(saleItem.product.name),
                  subtitle: Text('Quantity: ${saleItem.quantity}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove, color: Colors.red),
                    onPressed: () => _removeProductFromSale(saleItem),
                  ),
                );
              },
            ),
          ),
          Text('Total: \$${_totalValue.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: _saveSale,
            child: Text('Save Sale'),
          ),
        ],
      ),
    );
  }
}
