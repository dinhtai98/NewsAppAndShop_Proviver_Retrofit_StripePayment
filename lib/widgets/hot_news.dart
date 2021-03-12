import 'package:flutter/material.dart';
import 'package:flutter_demo/models/article.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/reponsitory/reponsitory_get_hot_news.dart';
import 'package:flutter_demo/screens/news_detail.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class HotNewsWidget extends StatefulWidget {
  @override
  _HotNewsWidgetState createState() => _HotNewsWidgetState();
}

class _HotNewsWidgetState extends State<HotNewsWidget> {
  final GetHotNews _reponsitory = GetHotNews();
  @override
  Widget build(BuildContext context) {
    return _reponsitory.buildHotNews(
        context, (data) => _buildHotNewsWidget(data));
  }

  Widget _buildHotNewsWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return Container(
        height: articles.length / 2 * 210.0,
        padding: EdgeInsets.all(5.0),
        child: new GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DetailNews(
                  //               article: articles[index],
                  //             )));
                  Navigator.of(context).pushNamed(
                    DetailNews.routeName,
                    arguments: articles[index],
                  );
                },
                child: Container(
                  width: 220.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: articles[index].url,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                image: DecorationImage(
                                    image: articles[index].urlToImage == null
                                        ? AssetImage(
                                            "assets/img/placeholder.jpg")
                                        : NetworkImage(
                                            articles[index].urlToImage),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                        child: Text(
                          articles[index].title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(height: 1.2, fontSize: 15.0),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 180,
                            height: 1.0,
                            color: Colors.black12,
                          ),
                          Container(
                            width: 30,
                            height: 3.0,
                            color: Style.Colors.mainColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              articles[index].source.name,
                              style: TextStyle(
                                  color: Style.Colors.mainColor, fontSize: 9.0),
                            ),
                            Text(
                              timeUntil(
                                  DateTime.parse(articles[index].publishedAt)),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 9.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
