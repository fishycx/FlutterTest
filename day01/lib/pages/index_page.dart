import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_index.dart';
import 'home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common_utils/common_utils.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.home),
      // ignore: deprecated_member_use
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.search),
      // ignore: deprecated_member_use
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.shopping_cart),
      // ignore: deprecated_member_use
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.profile_circled),
      // ignore: deprecated_member_use
      title: Text('会员中心')
    ),
  ];
  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;
  var currentpage;

  @override
  void initState() {
    currentpage = tabBodies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    LogUtil.init(isDebug: true);

     ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(375, 667),
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentpage = tabBodies[index];
          });
        },
      ),
      body: currentpage,
    );
  }
}