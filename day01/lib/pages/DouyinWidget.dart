import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DouyinWidget extends StatelessWidget {
  final data;
  DouyinWidget({Key key, this.data}) : super(key: key);

  Widget _titleWidget() {
    return Row(
      children: [
        Container(
          child: new Image.asset("images/home/douyin.png"),
          padding: EdgeInsets.only(top: 10.w, left: 10.w),
        ),
        Expanded(
          child: Text(""),
        ),
        _rightWidget()
      ],
    );
  }

  Widget _rightWidget() {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Image.asset("images/home/home_more.png"),
          Container(
            child: Text("更多"),
            padding: EdgeInsets.only(left: 5.w),
          )
        ],
      ),
    );
  }

  String salesValue(value) {
    if (value < 10000) {
      return "已售$value件";
    } else {
      int count = (value / 10000).round();
      return "已售$count万件";
    }
  }

  Widget _productView() {
    List limitedBuyList = data;
    var container = Container(
        padding: EdgeInsets.only(top: 20.w),
        height: 177.w,
        child: ListView.builder(
            itemCount: limitedBuyList.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map model = limitedBuyList[index];
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.network(
                        model['mainPic'],
                        width: 85.w,
                        height: 85.w,
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('images/home/douyin.png'),
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Row(
                        children: [
                          Text(
                            "券后价￥",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFF42D51),
                            ),
                          ),
                          Text(
                            '${model['actualPrice']}',
                            style: TextStyle(
                              color: Color(0xFFF42D51),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.w),
                      height: 14.w,
                      width: 30.w,
                      color: Color(0xFFF42D51),
                      child: Text(
                        '券${model['couponPrice'].toString().split('.')[0]}',
                        style: TextStyle(color: Colors.white, fontSize: 10.w),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.w),
                      child: Text(
                        salesValue(model['monthSales']),
                        style:
                            TextStyle(color: Color(0xFF888888), fontSize: 10.w),
                      ),
                    )
                  ],
                ),
              );
            }));
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: container,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10), color: Colors.white),
      // height: 193.w,
      child: Column(
        children: [_titleWidget(), _productView()],
      ),
    );
  }
}
