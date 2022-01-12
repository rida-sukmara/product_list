// Mocks generated by Mockito 5.0.17 from annotations
// in product_list/test/domain/repositories/product_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:product_list/core/utils/i_network_info.dart' as _i6;
import 'package:product_list/data/datasource/local/i_product_local_datasource.dart'
    as _i3;
import 'package:product_list/data/datasource/remote/i_product_remote_datasource.dart'
    as _i5;
import 'package:product_list/data/models/product.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeProduct_0 extends _i1.Fake implements _i2.Product {}

/// A class which mocks [IProductLocalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIProductLocalDatasource extends _i1.Mock
    implements _i3.IProductLocalDatasource {
  MockIProductLocalDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Product>> all() =>
      (super.noSuchMethod(Invocation.method(#all, []),
              returnValue: Future<List<_i2.Product>>.value(<_i2.Product>[]))
          as _i4.Future<List<_i2.Product>>);
  @override
  _i4.Future<_i2.Product> findBy({String? id}) =>
      (super.noSuchMethod(Invocation.method(#findBy, [], {#id: id}),
              returnValue: Future<_i2.Product>.value(_FakeProduct_0()))
          as _i4.Future<_i2.Product>);
  @override
  _i4.Future<bool> cache({List<_i2.Product>? items}) =>
      (super.noSuchMethod(Invocation.method(#cache, [], {#items: items}),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.Product> addToWish({_i2.Product? product}) => (super
          .noSuchMethod(Invocation.method(#addToWish, [], {#product: product}),
              returnValue: Future<_i2.Product>.value(_FakeProduct_0()))
      as _i4.Future<_i2.Product>);
  @override
  _i4.Future<_i2.Product> removeFromWish({_i2.Product? product}) =>
      (super.noSuchMethod(
              Invocation.method(#removeFromWish, [], {#product: product}),
              returnValue: Future<_i2.Product>.value(_FakeProduct_0()))
          as _i4.Future<_i2.Product>);
}

/// A class which mocks [IProductRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIProductRemoteDatasource extends _i1.Mock
    implements _i5.IProductRemoteDatasource {
  MockIProductRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Product>> all() =>
      (super.noSuchMethod(Invocation.method(#all, []),
              returnValue: Future<List<_i2.Product>>.value(<_i2.Product>[]))
          as _i4.Future<List<_i2.Product>>);
  @override
  _i4.Future<_i2.Product> findBy({String? id}) =>
      (super.noSuchMethod(Invocation.method(#findBy, [], {#id: id}),
              returnValue: Future<_i2.Product>.value(_FakeProduct_0()))
          as _i4.Future<_i2.Product>);
}

/// A class which mocks [INetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockINetworkInfo extends _i1.Mock implements _i6.INetworkInfo {
  MockINetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool isConnected() => (super.noSuchMethod(Invocation.method(#isConnected, []),
      returnValue: false) as bool);
}
