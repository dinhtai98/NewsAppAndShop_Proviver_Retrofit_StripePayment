import 'package:flutter/material.dart';
import 'package:flutter_demo/models/source.dart';
import 'package:flutter_demo/models/source_response.dart';
import 'package:flutter_demo/reponsitory/repomsitory_get_soures.dart';
import 'package:flutter_demo/screens/source_detail.dart';
import 'package:flutter_demo/style/theme.dart' as Style;

class TopChannelsWidget extends StatefulWidget {
  @override
  _TopChannelsWidgetState createState() => _TopChannelsWidgetState();
}

class _TopChannelsWidgetState extends State<TopChannelsWidget> {
  final GetTopChannels _repository = GetTopChannels();
  @override
  Widget build(BuildContext context) {
    return _repository.buildTopChannels(
        context, (data) => _buildSourcesWidget(data));
  }

  Widget _buildSourcesWidget(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Sources",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 0.0),
              width: 80.0,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SourceDetail(
                  //               source: sources[index],
                  //             )));
                  Navigator.of(context).pushNamed(
                    SourceDetail.routeName,
                    arguments: sources[index],
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: sources[index].id,
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                              )
                            ],
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/logos/${sources[index].id}.png")),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sources[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sources[index].category,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
