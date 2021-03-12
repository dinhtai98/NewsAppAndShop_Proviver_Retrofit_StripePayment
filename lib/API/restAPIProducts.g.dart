// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restAPIProducts.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClientProducts implements RestClientProducts {
  _RestClientProducts(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://603de25048171b0017b2df63.mockapi.io/api/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<Product>> getProducts() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/product',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Product.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
