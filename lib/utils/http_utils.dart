import 'dart:io';
import 'package:dio/dio.dart';

class HttpUtils {
  // 全局变量
  static Dio dio;

  // 默认配置
  static const String API_PREFIX = 'http://guiyi.xyz:7300/mock/604cd2faba85b50020b05466/cb'; // url前缀
  static const int CONNECT_TIMEOUT = 10000; // 连接超时 ms
  static const int RECEIVE_TIMEOUT = 10000; // 响应超时 ms

  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    dio = createInstance();

    var result;

    try {
      Response response = await dio.request(url, data: data, options: Options(method: method));
      if(response.statusCode == 200) {
        result = response.data;
      } else {
        print('请求失败：' + response.toString());
      }
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }
    return result['data'];
  }

  // 创建Dio实例
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = Dio(options);
    }
    return dio;
  }
}
