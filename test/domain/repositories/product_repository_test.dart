import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/core/utils/i_network_info.dart';
import 'package:product_list/data/datasource/local/i_product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/i_product_remote_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/product_repository.dart';

import 'product_repository_test.mocks.dart';

@GenerateMocks(
    [IProductLocalDatasource, IProductRemoteDatasource, INetworkInfo])
void main() {
  late IProductLocalDatasource mockLocalDatasource;
  late IProductRemoteDatasource mockRemoteDatasource;
  late INetworkInfo mockNetworkInfo;
  late Product product;
  late Product productOnWish;
  late List<Product> listProduct;

  late ProductRepository sut;

  setUp(() {
    mockLocalDatasource = MockIProductLocalDatasource();
    mockRemoteDatasource = MockIProductRemoteDatasource();
    mockNetworkInfo = MockINetworkInfo();
    
    product = const Product(
        id: "1",
        name: "name",
        description: "description",
        price: "1",
        image: "");

    productOnWish =  const Product(
        id: "1",
        name: "name",
        description: "description",
        price: "1",
        image: "",
        isOnWishlist: true);

    listProduct = [product];

    sut = ProductRepository(
        localDatasource: mockLocalDatasource,
        remoteDatasource: mockRemoteDatasource,
        networkInfo: mockNetworkInfo);
  });
  group('isOnline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected()).thenReturn(true);
    });
    test('connection checking', () async {
      // arrange
      when(mockRemoteDatasource.all()).thenAnswer((_) async => listProduct);
      when(mockLocalDatasource.cache(items: listProduct))
          .thenAnswer((_) async => true);
      // act
      sut.all();
      // assert
      verify(mockNetworkInfo.isConnected());
    });

    test('fetching from remote when is online', () async {
      // arrange
      when(mockRemoteDatasource.all()).thenAnswer((_) async => listProduct);
      when(mockLocalDatasource.cache(items: listProduct))
          .thenAnswer((_) async => true);
      // act
      final actual = await sut.all();
      // assert
      verify(mockRemoteDatasource.all());
      verifyNoMoreInteractions(mockRemoteDatasource);
      expect(actual, Right(listProduct));
    });

    test('caching product when fetching success', () async {
      // arrange
      when(mockRemoteDatasource.all()).thenAnswer((_) async => listProduct);
      when(mockLocalDatasource.cache(items: listProduct))
          .thenAnswer((_) async => true);
      // act
      final actual = await sut.all();
      // assert
      verify(mockLocalDatasource.cache(items: listProduct));
      verifyNoMoreInteractions(mockLocalDatasource);
      expect(actual, Right(listProduct));
    });

    test('find by id check connection', () async {
      // arrange
      when(mockRemoteDatasource.findBy(id: product.id))
          .thenAnswer((_) async => product);
      // act
      await sut.findBy(id: product.id);
      // assert
      verify(mockNetworkInfo.isConnected());
    });

    test('find by id', () async {
      // arrange
      when(mockRemoteDatasource.findBy(id: product.id))
          .thenAnswer((_) async => product);
      // act
      final actual = await sut.findBy(id: product.id);
      // assert
      verify(mockRemoteDatasource.findBy(id: product.id));
      verifyNoMoreInteractions(mockRemoteDatasource);
      expect(actual, Right(product));
    });
  });

  group('isOffline', () {
    setUp(() async {
      when(mockNetworkInfo.isConnected()).thenReturn(false);
    });
    test('fetching from local storage', () async {
      // asert
      when(mockLocalDatasource.all()).thenAnswer((_) async => listProduct);
      // act
      final actual = await sut.all();
      // assert
      verify(mockLocalDatasource.all());
      expect(actual, Right(listProduct));
    });

    test('find by id', () async {
      // arrange
      when(mockLocalDatasource.findBy(id: product.id)).thenAnswer((_) async => product);
      // act
      final actual = await sut.findBy(id: product.id);
      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      expect(actual, Right(product));
     });
  });

  group('add to wish list', () {
    
    test('should return product added to wish', () async {
      // arrange
      when(mockLocalDatasource.addToWish(product: product)).thenAnswer((_) async => productOnWish);
      // act
      final actual = await sut.addToWish(product: product);
      // assert
      verify(mockLocalDatasource.addToWish(product: product));
      expect(actual, Right(productOnWish));
     });
    test('should return product removed from wish', () async {
      // arrange
      when(mockLocalDatasource.addToWish(product: productOnWish)).thenAnswer((_) async => product);
      // act
      final actual = await sut.addToWish(product: productOnWish);
      // assert
      verify(mockLocalDatasource.addToWish(product: productOnWish));
      expect(actual, Right(product));
     });
  });
}
