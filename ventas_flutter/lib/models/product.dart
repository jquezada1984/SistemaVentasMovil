/***************
 * Desarrollador: John Kleber Quezada
 * Fecha: 12/07/2024
 * Descripcion Creacion de la clase de Producto.
 */
class Product {
  final int? id;
  final String name;
  final String category;
  final double price;

  Product({this.id, required this.name, required this.category, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
    );
  }
}