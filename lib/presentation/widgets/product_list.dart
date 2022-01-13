import 'package:flutter/material.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/presentation/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  final List<Product> items;
  final Function callback;
  const ProductList({required this.items, required this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ProductCard(product: items[index], callback: callback);
        });
  }
}
