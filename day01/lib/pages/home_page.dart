import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('有蜜生活'),
        ),
        body: FutureBuilder(
          future: getHomePageContent(), 
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            var bannerList;
            var data = snapshot.data;
            var componentList = data['data'];
            for (var componentData in componentList) {
              var id = componentData['identifier'] as String;
              if (id == "banner") {
                 bannerList = componentData['data'];
              } else {

              }
            }
             return Column(
              children: [
                SwiperDiy(swiperDateList: bannerList)
              ],
            );
          } else {
            return Text('无数据');
          }
        }));
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          String url = swiperDateList[index]['icon'];
          print(url);
          return Image.network(url);
        },
        itemCount: swiperDateList.length,
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}
