import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config//service_url.dart';

//获取首页主题内容
Future getHomePageContent() async {
  print('开始获取首页数据..........');

  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = 'application/json';
    response = await dio.get(servicePath['homePageContent']);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('Error:========>${e}');
  }
}
