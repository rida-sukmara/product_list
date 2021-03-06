import 'package:product_list/core/utils/i_network_info.dart';
import 'package:product_list/data/datasource/local/i_product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';

class ProductRepository extends IProductRepository {
  final IProductLocalDatasource localDatasource;
  final ProductRemoteDatasource remoteDatasource;
  final INetworkInfo networkInfo;

  ProductRepository(
      {required this.localDatasource,
      required this.remoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> all([bool? forceRefresh]) async {
    if (await networkInfo.isConnected()) {
      try {
        final result = await remoteDatasource.all();
        final cached = await localDatasource.all();
        if (cached.isNotEmpty && forceRefresh == false) {
          return Right(cached);
        }
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
