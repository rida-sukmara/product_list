import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:product_list/data/models/product.dart';

part 'product_remote_datasource.g.dart';

@RestApi(baseUrl: "https://61da8de74593510017aff588.mockapi.io/api/v1")
abstract class ProductRemoteDatasource {
  factory ProductRemoteDatasource(Dio dio, {String baseUrl}) =
      _ProductRemoteDatasource;
  @GET("/Products")
  Future<List<Product>> all();
  @GET("/Products/{id}")
  Future<Product> findBy({@Path("id") required String id});
}
