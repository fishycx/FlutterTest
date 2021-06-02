import 'dart:developer';

import 'package:day01/config/service_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../config/httpHeaders.dart';
import 'package:common_utils/common_utils.dart';

//获取首页主题内容
Future getHomePageContent() async {
  print('开始获取首页数据..........');

  try {
    Response response;

   var options =  BaseOptions(
     responseType:  ResponseType.json,
     baseUrl: serviceUrl,
     headers: httpHeaders
   );

    Dio dio = new Dio(options);   

    response = await dio.get(servicePath['homePageContent'], queryParameters: baseParams());
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('Error:========>${e}');
  }
}
