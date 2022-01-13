import 'package:dartz/dartz.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:product_list/data/models/product.dart';

abstract class IProductRepository {
  Future<Either<Failure, List<Product>>> all([bool forceRefresh]);
  Future<Either<Failure, Product>> findBy({required String id});
  Future<Either<Failure, Product>> addToWish({required Product product});
  Future<Either<Failure, Product>> removeFromWish({required Product product});
}
