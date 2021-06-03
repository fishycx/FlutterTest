import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        backgroundColor: Color(0xF3F3F3),
        body: FutureBuilder(
            future: getHomePageContent(),
            builder: (context, snapshot) {
              List<Widget> children = [];
              if (snapshot.hasData) {
                var data = snapshot.data;
                var componentList = data['data'];
                for (var componentData in componentList) {
                  var id = componentData['identifier'] as String;
                  if (id == "banner") {
                    children
                        .add(SwiperDiy(swiperDateList: componentData['data']));
                  } else if (id == "secondIcon") {
                    children.add(
                        TopNavigator(navigatorList: componentData['data']));
                  } else if (id == "section") {
                    children.add(ActionImageView(item: componentData['data']));
                  } else if (id == "rotation") {
                    children.add(RotationView(swiperDateList: componentData['data']));
                  }
                }
                return ListView(
                  children: children,
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
      margin: EdgeInsets.all(12.w),
      width: 351.w,
      height: 162.w,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          String url = swiperDateList[index]['icon'];
          return Image.network(url);
        },
        itemCount: swiperDateList.length,
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['icon'], width: ScreenUtil().setWidth(36)),
          Container(
            child: Text(
              item['name'],
              style: const TextStyle(
                  fontSize: 11, color: Color.fromRGBO(51, 51, 51, 1)),
            ),
            margin: EdgeInsets.only(top: 3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 15),
      decoration: new BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: new BorderRadius.circular(3)),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class ActionImageView extends StatelessWidget {
  final item;
  ActionImageView({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = EdgeInsets.fromLTRB(12, 0, 12, 0);
    if (item['expand'] == 1) {
      padding = EdgeInsets.zero;
    }
    return Container(
        padding: padding,
        alignment: Alignment.topCenter,
        width: ScreenUtil().setWidth(item['width'] / 3),
        child: Image.network(item['image']));
  }
}


class RotationView extends StatelessWidget {
  final List swiperDateList;
  RotationView({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      // width: 375.w,
      height: ScreenUtil().setWidth(110),
      alignment: Alignment.bottomCenter,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          String url = swiperDateList[index]['icon'];
          return Image.network(url);
        },
        itemCount: swiperDateList.length,
        autoplay: swiperDateList.length > 1,
        pagination: swiperDateList.length > 1 ? SwiperPagination() : null,
      ),
    );
  }
}