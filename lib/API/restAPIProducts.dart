import 'package:dio/dio.dart';
import 'package:flutter_demo/models/products/product.dart';
import 'package:retrofit/http.dart';

part 'restAPIProducts.g.dart';

@RestApi(baseUrl: "https://603de25048171b0017b2df63.mockapi.io/api/v1/")
abstract class RestClientProducts{
  factory RestClientProducts(Dio dio, {String baseUrl}) = _RestClientProducts;
  @GET("/product")
  Future<List<Product>> getProducts();
}