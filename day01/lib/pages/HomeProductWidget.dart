import 'package:day01/service/service_method.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatefulWidget {
  const HomeProductWidget({Key key}) : super(key: key);

  @override
  _HomeProductWidgetState createState() => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  String _content;
  Map product;
  Map talent;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> params = {'tailTime': null, 'headTime': null};
    request("homeProuct", params).then((value) {
      product = value['data']['product'];
      print(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('fishycx'),
    );
  }
}
