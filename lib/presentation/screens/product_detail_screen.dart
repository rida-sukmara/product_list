import 'package:flutter/material.dart';
import 'package:product_list/presentation/args/product_detail_args.dart';

class ProductDetailScreen extends StatelessWidget {

  static const route = '/product-detail';
  
  const ProductDetailScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as ProductDetailArgs;

    final product = args.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name),),
      body: Center(child: Text(product.name),)
    );
  }
}
