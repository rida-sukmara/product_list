import 'package:dartz/dartz.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:product_list/data/models/product.dart';

abstract class IProductRepository {
  Future<Either<Failure, List<Product>>> all();
  Future<Either<Failure, Product>> findBy({required String id});
  Future<Either<Failure, bool>> addToWish({required Product product});
  Future<Either<Failure, bool>> removeFromWish({required Product product});
}
