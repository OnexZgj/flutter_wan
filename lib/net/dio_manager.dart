import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wan/api/apis.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'intercept/LogInterceptors.dart';

Dio _dio = Dio();

Dio get dio => _dio;

class DioManager {
  static Future init() async {
    dio.options.baseUrl = Apis.BASE_HOST;
    dio.options.connectTimeout = 30 * 1000;
    dio.options.sendTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    // TODO 网络环境监听
    dio.interceptors.add(LogInterceptors());
    // dio.interceptors.add(WanAndroidErrorInterceptor());
    // dio.interceptors.add(CookieInterceptor2());

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    print('DioUtil : http cookie path = $tempPath');
    CookieJar cj = PersistCookieJar(dir: tempPath, ignoreExpires: true);
    // dio.interceptors.add(CookieInterceptor(cj));
  }
}
