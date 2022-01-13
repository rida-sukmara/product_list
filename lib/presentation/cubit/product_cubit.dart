import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/core/error/failure.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  late final IProductRepository _productRepository;

  ProductCubit({required IProductRepository repository, ProductState? initialState})
      : super(initialState ?? ProductInitial()) {
    _productRepository = repository;
    getProducts();
  }

  Future<void> toggleWish({required Product product}) async {
    try {
      if (product.isOnWishlist) {
        emit(ProductRemoveFromWish(product));
        final result =
            await _productRepository.removeFromWish(product: product);
        if (result.isRight()) {
          emit(ProductWishComplate(result.getOrElse(() => product)));
        } else {
          emit(const ProductWishFailure(message: "Failed while saving data."));
        }
      } else {
        emit(ProductAddToWish(product));
        final result = await _productRepository.addToWish(product: product);
        if (result.isRight()) {
          emit(ProductWishComplate(result.getOrElse(() => product)));
        } else {
          emit(const ProductWishFailure(message: "Failed while saving data."));
        }
      }
    } catch (e) {
      emit(const ProductWishFailure(message: "Failed while saving data."));
    }
  }

  Future<void> getProducts([bool forceFetching = false]) async {
    try {
      emit(ProductLoading());
      final result = await _productRepository.all(forceFetching);
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
      emit(const ProductFailure(message: "Oops... something when wrong!"));
    }
  }
}
