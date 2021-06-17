import 'package:day01/pages/DowntownWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LimitedBuyView extends StatelessWidget {
  final data;
  LimitedBuyView({Key key, this.data}) : super(key: key);

  Widget _titleWidget() {
    return Row(
      children: [
        Container(
          child: new Image.asset("images/home/limitedBuy.png"),
          padding: EdgeInsets.only(top: 10.w, left: 10.w),
        ),
        DowntownWidget(
          nexHour: data['nextHour'],
          nowTime: data['nowTime'],
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

  Widget _productView() {
    List limitedBuyList = data['list'];
    var container = Container(
        padding: EdgeInsets.only(top: 20.w),
        height: 147.w,
        child: ListView.builder(
            itemCount: limitedBuyList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Image.network(
                      limitedBuyList[index]['mainPic'],
                      width: 85.w,
                      height: 85.w,
                    ),
                    Container(
                      child: Text(
                        limitedBuyList[index]['title'],
                        maxLines: 1,
                      ),
                      padding: EdgeInsets.only(top: 5.w),
                      width: 85.w,
                      height: 23.w,
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
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10), color: Colors.white),
      // height: 193.w,
      child: Column(
        children: [_titleWidget(), _productView()],
      ),
    );
  }
}
