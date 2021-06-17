import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DowntownWidget extends StatefulWidget {
  final int nowTime;
  final int nexHour;
  DowntownWidget({Key key, this.nexHour, this.nowTime}) : super(key: key);

  @override
  _DowntownWidgetState createState() => _DowntownWidgetState();
}

class _DowntownWidgetState extends State<DowntownWidget> {
  String _hour = "00";
  String _minute = "00";
  String _seconds = "00";
  int targetInterval = 0;

  Timer _timer;

  void initState() {
    super.initState();
    caculateEndTime();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      //定时任务
      updateUI();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void caculateEndTime() {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.nowTime);
    targetInterval = DateTime(date.year, date.month, date.day, widget.nexHour)
        .millisecondsSinceEpoch;
  }

  void updateUI() {
    setState(() {
      DateTime nowDate = DateTime.now();
      DateTime targetDate = DateTime.fromMillisecondsSinceEpoch(targetInterval);
      List list = targetDate.difference(nowDate).toString().split(":");

      _hour = '${list[0]}';
      _minute = '${list[1]}';
      _seconds = '${list[2].toString().split(".")[0]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _maskWidget() {
      return Container(
        width: 10.w,
        height: 18.w,
        child: Text(":"),
        alignment: Alignment.center,
      );
    }

    Widget _timeItemWidget(value) {
      return Container(
        child: Text(value,
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.0,
                  1.0
                ],
                colors: [
                  Color.fromARGB(255, 254, 1, 102),
                  Color.fromARGB(255, 255, 37, 83)
                ]),
            color: Colors.red),
        width: 20.w,
        height: 18.w,
        alignment: Alignment.center,
      );
    }

    Widget hourWidget = _timeItemWidget(_hour);
    Widget miniuteWidget = _timeItemWidget(_minute);
    Widget secondWidget = _timeItemWidget(_seconds);

    return Container(
      child: Row(
        children: [
          hourWidget,
          _maskWidget(),
          miniuteWidget,
          _maskWidget(),
          secondWidget
        ],
      ),
      padding: EdgeInsets.only(top: 12.w, left: 14.w),
    );
  }
}
