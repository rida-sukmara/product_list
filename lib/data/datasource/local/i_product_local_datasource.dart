import 'package:product_list/data/models/product.dart';

abstract class IProductLocalDatasource {
  Future<List<Product>> all();
  Future<bool> cache({required List<Product> items});
  Future<Product> addToWish({required Product product});
  Future<Product> removeFromWish({required Product product});
}
