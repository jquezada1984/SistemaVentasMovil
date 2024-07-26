class Customer {
  final String id;
  final String name;
  final String ruc;
  final String address;

  Customer({
    required this.id,
    required this.name,
    required this.ruc,
    required this.address,
  });

  factory Customer.fromMap(Map<String, dynamic> data) {
    return Customer(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      ruc: data['ruc'] ?? '',
      address: data['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ruc': ruc,
      'address': address,
    };
  }
}
