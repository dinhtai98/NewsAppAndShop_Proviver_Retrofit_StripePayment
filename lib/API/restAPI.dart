import 'package:dio/dio.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/models/source_response.dart';
import 'package:retrofit/http.dart';

part 'restAPI.g.dart';

@RestApi(baseUrl: "http://newsapi.org/v2/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  @GET("/sources")
  Future<SourceResponse> getSources(
    @Query("apikey") String apiKey,
    @Query("language") String en,
    @Query("country") String us
  );

  @GET("/top-headlines")
  Future<ArticleResponse> getTopHeadlines(
    @Query("apikey") String apiKey,
    @Query("country") String us
  );

  @GET("/everything")
  Future<ArticleResponse> search(
    @Query("apikey") String apiKey,
    @Query("q") String input,
    @Query("sortBy") String popularity
  );

    @GET("/everything")
  Future<ArticleResponse> getHotNews(
    @Query("apikey") String apiKey,
    @Query("q") String input,
    @Query("sortBy") String popularity
  );

   @GET("/top-headlines")
  Future<ArticleResponse> getSourceNews(
    @Query("apikey") String apiKey,
    @Query("sources") String sourceId
  );
}
