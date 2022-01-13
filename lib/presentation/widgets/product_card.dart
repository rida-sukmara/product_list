import 'package:flutter/material.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/presentation/args/product_detail_args.dart';
import 'package:product_list/presentation/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function callback;

  const ProductCard({required this.product, required this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.route,
                  arguments: ProductDetailArgs(product: product))
              .then((_) => callback());
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(children: [
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                      "${product.image}?${product.name}${product.id}",
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    Text(
                      product.description,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "USD ${product.price}",
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    if (product.isOnWishlist)
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "This product on wish list",
                          style: TextStyle(
                              fontSize: 11, color: Colors.orangeAccent),
                        ),
                      )
                  ],
                ),
              ))
            ])));
  }
}
