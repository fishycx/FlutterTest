import 'package:day01/config/service_url.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';
import '../config/httpHeaders.dart';

Future request(url, [Map formData]) async {
  print('开始获取数据$url');
  try {
    Response response;
    var options = BaseOptions(
        responseType: ResponseType.json,
        baseUrl: serviceUrl,
        headers: httpHeaders);

    Dio dio = new Dio(options);
    Map<String, dynamic> params = {};
    params.addAll(baseParams());
    if (formData != null) {
      params.addAll(formData);
    }
    response = await dio.get(servicePath[url], queryParameters: params);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('Error:========>$e');
  }
}
