import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late final IProductRepository _productRepository;

  ProductCubit({required IProductRepository repository})
      : super(ProductInitial()) {
    _productRepository = repository;
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      emit(ProductLoading());
      final result = await _productRepository.all();
      if (result.isRight()) {
        emit(ProductLoaded(items: result.getOrElse(() => [])));
      } else {
        if (result is ServerFailure) {
          emit(const ProductFailure(
              message: "Something wrong while fetching data."));
        }
        if (result is CacheFailure) {
          emit(const ProductFailure(
              message: "Something wrong while geting cache data."));
        }
      }
    } catch (e) {
      print("product_cubit:all:e$e");
      emit(const ProductFailure(message: "Oops... something when wrong!"));
    }
  }
}