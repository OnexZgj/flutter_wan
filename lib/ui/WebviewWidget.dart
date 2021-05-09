import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/utils/RouterUtils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewWidget extends StatefulWidget {
  /// 标题
  String title;

  /// 链接
  String url;

  WebviewWidget({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebViewWidgetState();
  }
}

class WebViewWidgetState extends State<WebviewWidget> {
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((event) {
      if (event.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (event.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: Text(widget.title),
        bottom: new PreferredSize(
            child: SizedBox(
              height: 2,
              child: isLoad ? new LinearProgressIndicator() : Container(),
            ),
            preferredSize: Size.fromHeight(2)),
        actions: [
          IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                RouterUtil.launchInBrowser(widget.url, title: widget.title);
              })
        ],
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
    );
  }
}
