import 'package:product_list/data/models/product.dart';

abstract class IProductLocalDatasource {
  Future<List<Product>> all();
  Future<Product> findBy({required String id});
}
