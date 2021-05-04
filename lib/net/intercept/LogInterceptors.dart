import 'package:dio/dio.dart';

class LogInterceptors extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) async {

    print('┌─────────────────────Begin Request─────────────────────');
    printKV('uri', options.uri);
    printKV('method', options.method);
    printKV('queryParameters', options.queryParameters);
    printKV('contentType', options.contentType.toString());
    printKV('responseType', options.responseType.toString());

    StringBuffer stringBuffer = new StringBuffer();
    options.headers.forEach((key, v) => stringBuffer.write('\n  $key: $v'));
    printKV('headers', stringBuffer.toString());
    stringBuffer.clear();

    if (options.data != null) {
      printKV('body', options.data);
    }
    print('└—————————————————————End Request———————————————————————\n\n');

    return options;
  }

  printKV(String key, Object value) {
    printLong('$key: $value');
  }

  int maxLength = 340;

  void printLong(String log) {
    if (log.length < maxLength) {
      print(log);
    } else {
      while (log.length > maxLength) {
        print(log.substring(0, maxLength));
        log = log.substring(maxLength);
      }
      /// 打印剩余部分
      print(log);
    }
  }

}