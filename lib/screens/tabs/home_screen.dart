
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/headline_slider.dart';
import 'package:flutter_demo/widgets/hot_news.dart';
import 'package:flutter_demo/widgets/top_channels.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build home screen');
    return ListView(
      children: [
        HeadlingSliderWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              children: <Widget>[
                Text("Top channels", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),),  
              ],
            ),
        ),
        TopChannelsWidget(),
         Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              children: <Widget>[
                Text("Hot news", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0
                ),),  
              ],
            ),
        ),
        HotNewsWidget(),
      ],
    );
  }
}