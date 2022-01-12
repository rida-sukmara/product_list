import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/i_product_repository.dart';
import 'package:product_list/domain/usecases/find_product_by_id.dart';

import 'get_all_product_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  
  late IProductRepository mockProductRepository;

  late FindProductById sut;

  late Product product;

  setUp(() {
    mockProductRepository = MockIProductRepository();
    product = const Product(id: "1", name: "name", description: "description", price: "100", image: "image");
    sut = FindProductById(repository: mockProductRepository);
  });
  group('find product by usecase', () {
    test('find product by id', () async {
      // arrange
      when(mockProductRepository.findBy(id: product.id)).thenAnswer((_) async => Right(product));
      // act
      final actual = await sut(product.id);
      // assert
      verify(mockProductRepository.findBy(id: product.id));
      verifyNoMoreInteractions(mockProductRepository);
      expect(actual, Right(product));
     });
  });
}