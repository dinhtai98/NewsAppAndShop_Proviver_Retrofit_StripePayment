import 'package:flutter/material.dart';
import 'package:flutter_demo/models/article.dart';
import 'package:flutter_demo/models/article_response.dart';
import 'package:flutter_demo/models/source.dart';
import 'package:flutter_demo/reponsitory/reponsitory_get_source_news.dart';
import 'package:flutter_demo/screens/news_detail.dart';
import 'package:flutter_demo/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SourceDetail extends StatefulWidget {
  static const routeName = '/sourceDetail';
  final SourceModel source;

  const SourceDetail({Key key, this.source}) : super(key: key);
  @override
  _SourceDetailState createState() => _SourceDetailState(source);
}

class _SourceDetailState extends State<SourceDetail> {
  final SourceModel source;
  _SourceDetailState(this.source);
  final GetSourceNews _reponsitory = GetSourceNews();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: Style.Colors.mainColor,
            title: new Text(
              "",
            )),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            color: Style.Colors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                  tag: source.id,
                  child: SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/logos/${source.id}.png"),
                                fit: BoxFit.cover)),
                      )),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  source.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  source.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: _reponsitory.buildHotNews(
                  context, source.id, (data) => _buildSourceNewsWidget(data))),
        ],
      ),
    );
  }

  Widget _buildSourceNewsWidget(ArticleResponse data) {
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
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
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
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(articles[index].title,
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0)),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                        timeUntil(DateTime.parse(
                                            articles[index].publishedAt)),
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0))
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Hero(
                      tag: articles[index].url,
                      child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width * 2 / 5,
                          height: 130,
                          child: FadeInImage.assetNetwork(
                              alignment: Alignment.topCenter,
                              placeholder: 'assets/img/placeholder.png',
                              image: articles[index].urlToImage == null
                                  ? "http://to-let.com.bd/operator/images/noimage.png"
                                  : articles[index].urlToImage,
                              fit: BoxFit.fitHeight,
                              width: double.maxFinite,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 3)),
                    )
                  ],
                ),
              ),
            );
          });
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
