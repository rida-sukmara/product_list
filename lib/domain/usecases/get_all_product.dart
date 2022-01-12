import 'package:product_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/use_case.dart';

class GetAllProduct extends UseCase<List<Product>, void> {

  final IProductRepository repository;

  GetAllProduct({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call([void params]) async {
    return await repository.all();
  }
}
