import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/core/utils/network_info.dart';
import 'package:product_list/data/datasource/local/product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_list/data/models/product.dart';
import 'package:product_list/domain/repositories/product_repository.dart';
import 'package:product_list/presentation/args/product_detail_args.dart';
import 'package:product_list/presentation/cubit/product_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product-detail';

  late final Product product;

  late final ProductRemoteDatasource _remoteDatasource;
  late final ProductLocalDatasource _localDatasource;
  late final NetworkInfo _networkInfo;
  late final ProductCubit _productCubit;
  late final ProductRepository _productRepository;

  ProductDetailScreen({Key? key}) : super(key: key) {
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
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailArgs;

    product = args.product;

    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: BlocProvider(
          create: (_) => _productCubit,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                          "${product.image}?${product.name}${product.id}",
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(product.description),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      product.price,
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (_, state) {

                      Product _latestProduct = product;

                      if (state is ProductAddToWish) {
                        _latestProduct = state.product;
                      }

                      if (state is ProductRemoveFromWish) {
                        _latestProduct = state.product;
                      }

                      if (state is ProductWishComplate) {
                        _latestProduct = state.product;
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            _productCubit.toggleWish(product: _latestProduct);
                          },
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          child: Text(_latestProduct.isOnWishlist
                              ? "Remove from Wish list"
                              : "Add to wish list"),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
