// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restAPI.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://newsapi.org/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<SourceResponse> getSources(apiKey, en, us) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(en, 'en');
    ArgumentError.checkNotNull(us, 'us');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'language': en,
      r'country': us
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/sources',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SourceResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ArticleResponse> getTopHeadlines(apiKey, us) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(us, 'us');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'country': us
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/top-headlines',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ArticleResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ArticleResponse> search(apiKey, input, popularity) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(input, 'input');
    ArgumentError.checkNotNull(popularity, 'popularity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'q': input,
      r'sortBy': popularity
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/everything',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ArticleResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ArticleResponse> getHotNews(apiKey, input, popularity) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(input, 'input');
    ArgumentError.checkNotNull(popularity, 'popularity');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'q': input,
      r'sortBy': popularity
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/everything',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ArticleResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ArticleResponse> getSourceNews(apiKey, sourceId) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(sourceId, 'sourceId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'sources': sourceId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/top-headlines',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ArticleResponse.fromJson(_result.data);
    return value;
  }
}
