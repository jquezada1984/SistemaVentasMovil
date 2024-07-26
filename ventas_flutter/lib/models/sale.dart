import 'product.dart';
import 'customer.dart';

class Sale {
  final String id;
  final Customer customer;
  final List<SaleItem> items;
  final double totalValue;

  Sale({
    required this.id,
    required this.customer,
    required this.items,
    required this.totalValue,
  });

  factory Sale.fromMap(Map<String, dynamic> data) {
    return Sale(
      id: data['id'] ?? '',
      customer: Customer.fromMap(data['customer']),
      items: List<SaleItem>.from(
        data['items']?.map((item) => SaleItem.fromMap(item)) ?? [],
      ),
      totalValue: data['totalValue'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer': customer.toMap(),
      'items': items.map((item) => item.toMap()).toList(),
      'totalValue': totalValue,
    };
  }
}

class SaleItem {
  final Product product;
  int quantity;

  SaleItem({
    required this.product,
    required this.quantity,
  });

  factory SaleItem.fromMap(Map<String, dynamic> data) {
    return SaleItem(
      product: Product.fromMap(data['product']),
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
