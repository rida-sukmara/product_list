import 'package:product_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/use_case.dart';

class AddToWish extends UseCase<bool, Product> {
  final IProductRepository repository;

  AddToWish({required this.repository});

  @override
  Future<Either<Failure, bool>> call([Product? params]) async {
    return await repository.addToWish(product: params!);
  }
}
