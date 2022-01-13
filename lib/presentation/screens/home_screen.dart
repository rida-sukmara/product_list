import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/core/utils/network_info.dart';
import 'package:product_list/data/datasource/local/product_local_datasource.dart';
import 'package:product_list/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_list/domain/repositories/product_repository.dart';
import 'package:product_list/presentation/cubit/product_cubit.dart';
import 'package:product_list/presentation/widgets/product_list.dart';
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
        title: const Text("NTF Products"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: BlocProvider(
            create: (context) => _productCubit,
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
                  return RefreshIndicator(
                      child: ProductList(
                        items: state.items,
                        callback: () {
                          _productCubit.getProducts();
                        },
                      ),
                      onRefresh: () {
                        return _productCubit.getProducts(true);
                      });
                }

                return Container();
              },
            )),
      ),
    );
  }
}
