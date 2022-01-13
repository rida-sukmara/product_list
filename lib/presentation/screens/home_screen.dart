import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/core/utils/network_info.dart';
import 'package:product_list/data/datasource/local/product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/product_repository.dart';
import 'package:product_list/presentation/args/product_detail_args.dart';
import 'package:product_list/presentation/cubit/product_cubit.dart';
import 'package:product_list/presentation/screens/product_detail_screen.dart';
import 'package:product_list/presentation/widgets/product_shimmer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  late final ProductRemoteDatasource _remoteDatasource;
  late final ProductLocalDatasource _localDatasource;
  late final NetworkInfo _networkInfo;
  late final ProductCubit _productCubit;
  late final ProductRepository _productRepository;

  HomeScreen({Key? key}) : super(key: key) {
    _remoteDatasource = ProductRemoteDatasource(Dio());
    _localDatasource = ProductLocalDatasource();
    _networkInfo = NetworkInfo(connectionChecker: Connectivity());
    _productRepository = ProductRepository(
        localDatasource: _localDatasource,
        remoteDatasource: _remoteDatasource,
        networkInfo: _networkInfo);
    _productCubit = ProductCubit(repository: _productRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: BlocProvider(
            create: (context) => _productCubit,
            child: BlocListener<ProductCubit, ProductState>(
              listener: (_, state) {
                // TODO: implement listener
              },
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (_, state) {
                  if (state is ProductLoading) {
                    return const ProductShimmer();
                  }

                  if (state is ProductLoaded) {
                    if (state.items.isEmpty) {
                      return const Center(
                        child: Text("No product available."),
                      );
                    }
                    return ProductList(items: state.items);
                  }

                  return Container();
                },
              ),
            )),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> items;

  const ProductList({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          return ProductCard(product: items[index]);
        });
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.route,
              arguments: ProductDetailArgs(product: product));
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
                  child: Image.network(product.image + "?${product.id}",
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
                      maxLines: 3,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "USD ${product.price}",
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    )
                  ],
                ),
              ))
            ])));
  }
}
