import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_list/data/models/product.dart';

import '../../utils/fixtures.dart';

void main() {
  group('product model test', () {
    test('create instance', () async {
      // act
      const sut = Product(
          id: "",
          name: "Product",
          description: "Description",
          price: "10",
          image: "");
      // assert
      // ignore: unnecessary_type_check
      assert(sut is Equatable);
    });

    test('create instance from json', () async {
      // arrange
      final jsonProduct = fixture(name: "product.json");
      // act
      final sut = Product.fromJson(jsonProduct);
      // assert
      expect(sut.id, jsonProduct['id']);
      expect(sut.name, jsonProduct['name']);
      expect(sut.description, jsonProduct['description']);
      expect(sut.price, jsonProduct['price']);
      expect(sut.image, jsonProduct['image']);
     });

     test('create json from instance', () async {
       // arrange
       const product = Product(id: "1", name: "Product", description: "Desc", price: "10", image: "");
       // act
       final actual = product.toJson();
       // assert
       expect(actual['id'], product.id);
       expect(actual['name'], product.name);
       expect(actual['description'], product.description);
       expect(actual['price'], product.price);
       expect(actual['image'], product.image);
      });
  });
}
