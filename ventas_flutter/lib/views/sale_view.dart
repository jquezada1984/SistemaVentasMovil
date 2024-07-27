import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../controllers/customer_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/sale_controller.dart';
import '../models/customer.dart';
import '../models/product.dart';
import '../models/sale.dart';

class SaleView extends StatefulWidget {
  @override
  _SaleViewState createState() => _SaleViewState();
}

class _SaleViewState extends State<SaleView> {
  final SaleController _saleController = SaleController();
  final CustomerController _customerController = CustomerController();
  final ProductController _productController = ProductController();
  final Uuid _uuid = Uuid();

  List<Customer> _customers = [];
  List<Product> _products = [];
  List<SaleItem> _saleItems = [];
  Customer? _selectedCustomer;
  double _total = 0.0;

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

  void _addProductToSale(Product product) async {
    int quantity = await _showQuantityDialog();
    if (quantity > 0) {
      final existingItem = _saleItems.firstWhere((item) => item.productId == product.id, orElse: () => SaleItem(productId: product.id, productName: product.name, price: product.price, quantity: 0));
      setState(() {
        if (existingItem.quantity == 0) {
          _saleItems.add(existingItem);
        }
        existingItem.quantity += quantity;
      });
      _updateTotal();
    }
  }

  Future<int> _showQuantityDialog() async {
    int quantity = 1;
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Quantity'),
            onChanged: (value) {
              quantity = int.tryParse(value) ?? 1;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(0);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(quantity);
              },
            ),
          ],
        );
      },
    ) ?? 0;
  }

  void _updateTotal() {
    setState(() {
      _total = _saleItems.fold(0.0, (sum, item) => sum + item.total);
    });
  }

  void _saveSale() {
    if (_selectedCustomer != null && _saleItems.isNotEmpty) {
      final sale = Sale(
        id: _uuid.v4(),
        customerId: _selectedCustomer!.id,
        items: _saleItems,
        total: _total,
      );
      _saleController.addSale(sale);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a customer and add products to the sale.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Sale')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Customer>(
              hint: Text('Select Customer'),
              value: _selectedCustomer,
              onChanged: (customer) {
                setState(() {
                  _selectedCustomer = customer;
                });
              },
              items: _customers.map((customer) {
                return DropdownMenuItem<Customer>(
                  value: customer,
                  child: Text(customer.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
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
                    title: Text(saleItem.productName),
                    subtitle: Text('\$${saleItem.price.toStringAsFixed(2)} x ${saleItem.quantity} = \$${saleItem.total.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          saleItem.quantity--;
                          if (saleItem.quantity == 0) {
                            _saleItems.remove(saleItem);
                          }
                          _updateTotal();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text('Total: \$${_total.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveSale,
              child: Text('Save Sale'),
            ),
          ],
        ),
      ),
    );
  }
}

