import 'package:product_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/use_case.dart';

class FindProductById extends UseCase<Product, String> {

  final IProductRepository repository;

  FindProductById({required this.repository});

  @override
  Future<Either<Failure, Product>> call([String? params]) async {
    return await repository.findBy(id: params!);
  } 
}
