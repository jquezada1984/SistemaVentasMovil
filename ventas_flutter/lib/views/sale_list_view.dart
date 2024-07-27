import 'package:flutter/material.dart';
import '../controllers/sale_controller.dart';
import '../models/sale.dart';
import 'sale_view.dart'; // Asegúrate de importar la vista de creación de ventas

class SaleListView extends StatefulWidget {
  @override
  _SaleListViewState createState() => _SaleListViewState();
}

class _SaleListViewState extends State<SaleListView> {
  final SaleController _saleController = SaleController();
  List<Sale> _sales = [];

  @override
  void initState() {
    super.initState();
    _refreshSales();
  }

  void _refreshSales() async {
    final sales = await _saleController.getSales();
    setState(() {
      _sales = sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales List'),
      ),
      body: ListView.builder(
        itemCount: _sales.length,
        itemBuilder: (context, index) {
          final sale = _sales[index];
          return ListTile(
            title: Text('Sale ID: ${sale.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer ID: ${sale.customerId}'),
                Text('Total: \$${sale.total.toStringAsFixed(2)}'),
                ...sale.items.map((item) => Text('${item.productName}: \$${item.price.toStringAsFixed(2)} x ${item.quantity} = \$${item.total.toStringAsFixed(2)}')),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaleView()),
          ).then((_) => _refreshSales());
        },
      ),
    );
  }
}

