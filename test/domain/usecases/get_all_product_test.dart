import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/get_all_product.dart';

import 'get_all_product_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  late final IProductRepository mockProductRepository;
  late final List<Product> productList;

  late final GetAllProduct sut;

  setUp(() {
    mockProductRepository = MockIProductRepository();
    productList = [
      const Product(
          id: "1",
          name: "Product",
          description: "description",
          price: "100",
          image: "")
    ];

    sut = GetAllProduct(repository: mockProductRepository);
  });
  group('get all product use case', () {
    test('fetch all product from repository', () async {
      // arrange
      when(mockProductRepository.all())
          .thenAnswer((_) async => Right(productList));
      // act
      final actual = await sut();
      // assert
      verify(mockProductRepository.all());
      verifyNoMoreInteractions(mockProductRepository);
      expect(actual, Right(productList));
    });
  });
}
