class User {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String city;

  User({required this.id, required this.name, required this.address, required this.phone, required this.city});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      phone: data['phone'],
      city: data['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'city': city,
    };
  }
}
