import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/article.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/reponsitory/reponsitory_get_top_headline.dart';
import 'package:flutter_demo/screens/news_detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlingSliderWidget extends StatefulWidget {
  @override
  _HeadlingSliderWidgetState createState() => _HeadlingSliderWidgetState();
}

class _HeadlingSliderWidgetState extends State<HeadlingSliderWidget> {
  // final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  final GetTopHeadlines _repository = GetTopHeadlines();
  @override
  Widget build(BuildContext context) {
    return _repository.buildheadlingslider(
        context, (data) => _buildHeadlineSliderWidget(data));
  }

  Widget _buildHeadlineSliderWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
        child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: false,
              height: 200.0,
              viewportFraction: 0.9,
            ),
            items: getExpenseSliders(articles)));
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles
        .map(
          (article) => GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DetailNews(
              //               article: article,
              //             )));
              Navigator.of(context).pushNamed(
                DetailNews.routeName,
                arguments: article,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: article.url,
                    child: Container(
                        decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: article.urlToImage == null
                              ? AssetImage("assets/img/placeholder.png")
                              : NetworkImage(article.urlToImage)),
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ]),
                    ),
                  ),
                  Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                              article.title,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Text(
                        article.source.name,
                        style: TextStyle(color: Colors.white54, fontSize: 9.0),
                      )),
                  Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Text(
                        timeUntil(DateTime.parse(article.publishedAt)),
                        style: TextStyle(color: Colors.white54, fontSize: 9.0),
                      )),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
