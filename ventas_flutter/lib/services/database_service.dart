import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/sale.dart';
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;


  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        address TEXT,
        phone TEXT,
        city TEXT,
        password TEXT
      )
      '''
    );
    await db.execute(
      '''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT,
        price REAL
      )
      '''
    );
    await db.execute('''
          CREATE TABLE customers(
            id TEXT PRIMARY KEY,
            name TEXT,
            ruc TEXT,
            address TEXT
          )
        ''');
     await db.execute('''
          CREATE TABLE sales(
            id TEXT PRIMARY KEY,
            customerId TEXT,
            total REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE saleItems(
            id TEXT PRIMARY KEY,
            saleId TEXT,
            productId TEXT,
            productName TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        '''
        ALTER TABLE users ADD COLUMN password TEXT
        '''
      );
    }
    if (oldVersion < 3) {
      await db.execute(
        '''
        CREATE TABLE products(
          id TEXT PRIMARY KEY,
          name TEXT,
          price REAL
        )
        '''
      );
    }
  }

  // User methods
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<void> deleteProduct(String id) async {
    final db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

 Future<void> insertCustomer(Customer customer) async {
    final db = await database;
    await db.insert('customers', customer.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCustomer(Customer customer) async {
    final db = await database;
    await db.update('customers', customer.toMap(), where: 'id = ?', whereArgs: [customer.id]);
  }

  Future<void> deleteCustomer(String id) async {
    final db = await database;
    await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }

Future<void> insertSale(Sale sale) async {
    final db = await database;
    await db.insert('sales', {
      'id': sale.id,
      'customerId': sale.customerId,
      'total': sale.total,
    });
    for (var item in sale.items) {
      await db.insert('saleItems', item.toMap());
    }
  }

  Future<void> updateSale(Sale sale) async {
    final db = await database;
    await db.update('sales', {
      'id': sale.id,
      'customerId': sale.customerId,
      'total': sale.total,
    });
    for (var item in sale.items) {
      await db.update('saleItems', item.toMap(), where: 'id = ?', whereArgs: [item.productId]);
    }
  }

  Future<void> deleteSale(String id) async {
    final db = await database;
    await db.delete('sales', where: 'id = ?', whereArgs: [id]);
    await db.delete('saleItems', where: 'saleId = ?', whereArgs: [id]);
  }

  Future<List<Sale>> getSales() async {
    final db = await database;
    final List<Map<String, dynamic>> salesMaps = await db.query('sales');
    final List<Map<String, dynamic>> itemsMaps = await db.query('saleItems');

    return salesMaps.map((saleMap) {
      final saleItems = itemsMaps
          .where((itemMap) => itemMap['saleId'] == saleMap['id'])
          .map((itemMap) => SaleItem.fromMap(itemMap))
          .toList();

      return Sale(
        id: saleMap['id'],
        customerId: saleMap['customerId'],
        items: saleItems,
        total: saleMap['total'],
      );
    }).toList();
  }


}
