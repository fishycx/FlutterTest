import 'package:day01/pages/DouyinWidget.dart';
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'HomeProductWidget.dart';
import 'LimitedBuyView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Map data;
  List bannerList;
  List secondIconList;
  List rataionList;
  Map sectionItem;
  Map limitedData;
  List douyinData;

  String tailTime;
  String headTime;
  Map product;
  Map talent;
  bool hasNextPage = true;
  List hotGoodsList = [];

  GlobalKey<ClassicalFooterWidgetState> _footerkey =
      new GlobalKey<ClassicalFooterWidgetState>();
  GlobalKey<ClassicalHeaderWidgetState> _headerkey =
      new GlobalKey<ClassicalHeaderWidgetState>();

  @override
  void initState() {
    _getHotGoods();
    super.initState();
  }

  List<Widget> homeContent() {
    List<Widget> children = [];
    var componentList = data['data'];
    for (var componentData in componentList) {
      var id = componentData['identifier'] as String;
      if (id == "banner") {
        bannerList = componentData['data'];
        children.add(SwiperDiy(swiperDateList: bannerList));
      } else if (id == "secondIcon") {
        secondIconList = componentData['data'];
        children.add(TopNavigator(navigatorList: secondIconList));
      } else if (id == "section") {
        sectionItem = componentData['data'];
        children.add(ActionImageView(item: sectionItem));
      } else if (id == "rotation") {
        rataionList = componentData['data'];
        children.add(RotationView(swiperDateList: rataionList));
      } else if (id == "fast") {
        limitedData = componentData['data'];
        if (limitedData != null) {
          children.add(LimitedBuyView(
            data: limitedData,
          ));
        }
      } else if (id == "trill") {
        douyinData = componentData['data'];
        children.add(DouyinWidget(
          data: douyinData,
        ));
      }
    }
    children.add(HomeProductWidget(
      hotGoodsList: hotGoodsList,
    ));
    return children;
  }

  void _getHotGoods() {
    Map<String, dynamic> params = {'tailTime': tailTime, 'headTime': headTime};
    request("homeProuct", params).then((value) {
      product = value['data']['product'];
      // talent = value['data']['talent'];
      tailTime = product['tailTime'].toString();
      headTime = product['headTime'].toString();
      List records = product['records'];
      hasNextPage = records.isNotEmpty;
      setState(() {
        hotGoodsList.addAll(records);
      });
    });
  }

  String homePageContent = '正在获取数据';
  @override
  Widget build(BuildContext context) {
    List<Widget> homeContents;
    return Scaffold(
        appBar: AppBar(
          title: Text('有蜜生活'),
        ),
        backgroundColor: Color(0xF3F3F3),
        body: FutureBuilder(
            future: request("homePageContent"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                data = snapshot.data;
                homeContents = homeContent();
                return EasyRefresh(
                  bottomBouncing: true,
                  header: ClassicalHeader(
                      key: _headerkey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      refreshReadyText: '释放即可刷新',
                      refreshText: '下拉即可刷新',
                      refreshedText: '数据已刷新',
                      refreshFailedText: '加载失败',
                      refreshingText: '正在刷新',
                      showInfo: false),
                  footer: ClassicalFooter(
                    key: _footerkey,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    noMoreText: '没有更多了',
                    loadReadyText: '上拉加载',
                    loadingText: '加载中',
                  ),
                  child: ListView(
                    children: homeContents,
                  ),
                  onLoad: () async {
                    _getHotGoods();
                  },
                  onRefresh: () async {
                    request('homePageContent').then((value) {
                      setState(() {
                        data = value;
                        homeContents = homeContent();
                      });
                    });
                  },
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
              style: TextStyle(
                fontSize: ScreenUtil().setSp(11),
                color: Color.fromRGBO(51, 51, 51, 1),
              ),
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
      margin: EdgeInsets.all(12.w),
      height: ScreenUtil().setHeight(150.w),
      padding: EdgeInsets.only(top: 15.w),
      decoration: new BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: new BorderRadius.circular(3.w)),
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        padding: EdgeInsets.all(5.w),
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
