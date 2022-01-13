part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> items;
  const ProductLoaded({required this.items});
}

class ProductFailure extends ProductState {
  final String message;
  const ProductFailure({required this.message});
}

class WithProduct extends ProductState {
  final Product product;

  const WithProduct({required this.product});
}

class ProductAddToWish extends WithProduct {
  const ProductAddToWish(Product product) : super(product: product);
}

class ProductRemoveFromWish extends WithProduct {
  const ProductRemoveFromWish(Product product) : super(product: product);
}

class ProductWishComplate extends WithProduct {
  const ProductWishComplate(Product product) : super(product: product);
}
class ProductWishFailure extends ProductState {
  final String message;
  const ProductWishFailure({required this.message});
}
