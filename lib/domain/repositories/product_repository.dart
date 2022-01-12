import 'package:product_list/core/utils/i_network_info.dart';
import 'package:product_list/data/datasource/local/i_product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/i_product_remote_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';

class ProductRepository extends IProductRepository {
  final IProductLocalDatasource localDatasource;
  final IProductRemoteDatasource remoteDatasource;
  final INetworkInfo networkInfo;

  ProductRepository(
      {required this.localDatasource,
      required this.remoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> all() async {
    if (networkInfo.isConnected()) {
      try {
        final result = await remoteDatasource.all();
        await localDatasource.cache(items: result);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await localDatasource.all();
        return Right(result);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> findBy({required String id}) async {
    if (networkInfo.isConnected()) {
      final result = await remoteDatasource.findBy(id: id);
      return Right(result);
    } else {
      try {
        final result = await localDatasource.findBy(id: id);
        return Right(result);
      } catch (_) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> addToWish({required Product product}) async {
    try {
      final result = await localDatasource.addToWish(product: product);
      return Right(result);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> removeFromWish({required Product product}) async {
    try {
      final result = await localDatasource.removeFromWish(product: product);
      return Right(result);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
