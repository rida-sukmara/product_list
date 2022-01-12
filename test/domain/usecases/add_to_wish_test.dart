import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/add_to_wish.dart';

import 'add_to_wish_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  late final IProductRepository mockProductRepository;
  late final Product product;

  late final AddToWish sut;

  setUp(() {
    mockProductRepository = MockIProductRepository();
    product = const Product(
        id: "1",
        name: "name",
        description: "description",
        price: "10",
        image: "");
    sut = AddToWish(repository: mockProductRepository);
  });

  group('add to wish usecase', () {
    test('should return product with add to wishlist', () async {
      // arrange
      when(mockProductRepository.addToWish(product: product))
          .thenAnswer((_) async => Right(product));
      // act
      final actual = await sut(product);
      // assert
      verify(mockProductRepository.addToWish(product: product));
      verifyNoMoreInteractions(mockProductRepository);
      expect(actual, Right(product));
    });
  });
}
