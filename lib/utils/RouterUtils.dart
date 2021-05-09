import 'package:flutter/cupertino.dart';
import 'package:flutter_wan/ui/WebviewWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class RouterUtil{
  static void push(BuildContext context,Widget page) async{
    await Navigator.push(context, new CupertinoPageRoute(builder: (context) => page));
  }


  /// 跳转到 WebView 打开
  static void toWebView(BuildContext context, String title, String url) async {
    if (context == null || url.isEmpty) return;
    if (url.endsWith('.apk')) {
      launchInBrowser(url, title: title);
    } else {
      await Navigator.of(context)
          .push(new CupertinoPageRoute<void>(builder: (context) {
        return new WebviewWidget(
          title: title,
          url: url,
        );
      }));
    }
  }



  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

}