import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProductWidget extends StatefulWidget {
  List hotGoodsList = [];

  HomeProductWidget({Key key, this.hotGoodsList}) : super(key: key);
  @override
  _HomeProductWidgetState createState() => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  @override
  void initState() {
    super.initState();
  }

  Widget productTile = Container(
    margin: EdgeInsets.only(top: 10),
    child: Image.asset("images/home/home_pdtTitle.png"),
    alignment: Alignment.center,
  );

  String formatUrl(String url) {
    if (url.startsWith('https') || url.startsWith('http')) {
      return url;
    } else {
      return 'https:' + url;
    }
  }

  Widget _wrapList() {
    List hotGoodsList = widget.hotGoodsList;
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((e) {
        double productWidth = ((ScreenUtil().screenWidth - 29.w) / 2);
        return InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 5.w),
            width: productWidth,
            height: 300.w,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.network(
                  formatUrl(e['mainPic']),
                  width: 165.w,
                  height: 165.w,
                  alignment: Alignment.center,
                ),

                //商品标题
                _titleWidget(e['title']),
                //券后价
                _pdtPriceWidget(e),
                //原价
                _originPriceWidget(e),
                //优惠券
                _couponWidget(e),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Container _couponWidget(e) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 9.w),
      alignment: Alignment.centerLeft,
      height: 17.h,
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              'images/home/home_coupon.png',
              fit: BoxFit.fill,
              centerSlice: Rect.fromLTRB(24.0.w, 6.0.w, 27.0.w, 7.0.w),
            ),
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24.w, 2.w, 5.w, 0.w),
            child: Text(
              e['couponPrice'].toString(),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Color(0xffFB2020),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _originPriceWidget(e) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.w),
          alignment: Alignment.centerLeft,
          height: 21.w,
          child: Text(
            "￥" + e['originalPrice'].toString(),
            style: TextStyle(
              color: Color(0xffAAAAAA),
              fontSize: ScreenUtil().setSp(12),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        Expanded(child: Text('')),
        Container(
          padding: EdgeInsets.only(right: 10.w),
          child: Text(
            '已售${e['monthSales']}件',
            style: TextStyle(
              color: Color(0xff999999),
              fontSize: ScreenUtil().setSp(10),
            ),
          ),
        ),
      ],
    );
  }

  Container _pdtPriceWidget(e) {
    return Container(
      height: 23.w,
      margin: EdgeInsets.only(left: 10.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            '券后  ',
            style: TextStyle(
                color: Color(0xff888888), fontSize: ScreenUtil().setSp(12)),
            textAlign: TextAlign.left,
          ),
          Text(
            e['actualPrice'].toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(13),
              color: Color(0xff000000),
            ),
          )
        ],
      ),
    );
  }

  Widget _titleWidget(title) {
    return Container(
      padding: EdgeInsets.only(top: 7.w, left: 10.w, right: 10.w),
      child: Text.rich(
        TextSpan(children: [
          WidgetSpan(
              child: Image.asset(
            'images/home/pdt_tb.png',
            width: 14.w,
            height: 14.w,
          )),
          TextSpan(
            text: ' ' + title,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: ScreenUtil().setSp(14),
            ),
          ),
        ]),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _products() {
    return Container(
      child: Column(
        children: [productTile, _wrapList()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _products(),
    );
  }
}
