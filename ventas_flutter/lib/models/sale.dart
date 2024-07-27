class SaleItem {
  final String productId;
  final String productName;
  final double price;
  int quantity;

  SaleItem({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  factory SaleItem.fromMap(Map<String, dynamic> data) {
    return SaleItem(
      productId: data['productId'],
      productName: data['productName'],
      price: data['price'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }
}

class Sale {
  final String id;
  final String customerId;
  final List<SaleItem> items;
  final double total;

  Sale({
    required this.id,
    required this.customerId,
    required this.items,
    required this.total,
  });

  factory Sale.fromMap(Map<String, dynamic> data) {
    return Sale(
      id: data['id'],
      customerId: data['customerId'],
      items: (data['items'] as List).map((item) => SaleItem.fromMap(item)).toList(),
      total: data['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
    };
  }
}
