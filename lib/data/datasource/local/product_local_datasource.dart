import 'package:product_list/core/database/database_helper.dart';
import 'package:product_list/data/datasource/local/i_product_local_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:sqflite/sql.dart';

class ProductLocalDatasource implements IProductLocalDatasource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<Product> addToWish({required Product product}) async {
    final db = await databaseHelper.database;
    final productAdded = Product.copyWith(product: product, isOnWish: true);
    await db.update(Product.tableName, productAdded.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
    return productAdded;
  }

  @override
  Future<List<Product>> all() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(Product.tableName);
    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }

  @override
  Future<bool> cache({required List<Product> items}) async {
    final db = await databaseHelper.database;
    final batch = db.batch();

    for (var element in items) {
      batch.insert(Product.tableName, element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit();

    return true;
  }

  @override
  Future<Product> findBy({required String id}) {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<Product> removeFromWish({required Product product}) async {
    final db = await databaseHelper.database;
    final productAdded = Product.copyWith(product: product, isOnWish: false);
    await db.update(Product.tableName, productAdded.toJson(),
        where: 'id = ?', whereArgs: [product.id]);
    return productAdded;
  }
}
