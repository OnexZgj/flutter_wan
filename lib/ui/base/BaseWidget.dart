import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {
  BaseWeidgetState baseWeidgetState;

  @override
  State<StatefulWidget> createState() {
    baseWeidgetState = createBaseState();
    return baseWeidgetState;
  }

  BaseWeidgetState<BaseWidget> createBaseState();
}

abstract class BaseWeidgetState<T extends BaseWidget> extends State<T> {
  bool _isShowLoading = true;

  bool _isNetworkError = true;

  bool _isEmptyView = false;

  String _errorContentMsg = "网络请求失败，请检查您的网络";
  String _errorImgPath = "assets/images/ic_error.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            _attachBaseContentWidget(context),
            _attachLoadingWidget(context),
            _attachNetworkErrorWidget(context),
            _attachShowEmptyWidget(context)
          ],
        ),
      ),
    );
  }

  bool _isShowEmpty = false;

  Widget _attachShowEmptyWidget(BuildContext context) {
    return Offstage(
      offstage: !_isShowEmpty,
      child: attachShowEmptyWidget(context),
    );
  }

  /**
   * 构建空布局
   */
  Widget attachShowEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.hourglass_empty_rounded,
            ),
          ),
          Container(
            child: Text("空布局了。。。。"),
          )
        ],
      ),
    );
  }

  bool _isShowNetworkError = false;

  Widget _attachNetworkErrorWidget(BuildContext context) {
    return Offstage(
      offstage: !_isShowNetworkError,
      child: attachNetWorkErrorWidget(context),
    );
  }

  //网络错误的view
  Widget attachNetWorkErrorWidget(BuildContext context) {
    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image(
              image: AssetImage(_errorImgPath),
              width: 120,
              height: 120,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              _errorContentMsg,
              style: TextStyle(
                  color: Colors.deepOrange, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: OutlinedButton(
              child: Text("重新加载"),
              onPressed: () => {onClickErrorWidget()},
            ),
          )
        ],
      ),
    );
  }

  /**
   * 错误时候的点击事件
   */
  void onClickErrorWidget();

  Widget _attachLoadingWidget(BuildContext context) {
    return Offstage(
      offstage: !_isShowLoading,
      child: attachLoaingWeidget(context),
    );
  }

  bool _isShowContent = true;

  Widget _attachBaseContentWidget(BuildContext context) {
    return Offstage(
      offstage: !_isShowContent,
      child: attachContentWeidget(context),
    );
  }

  //设置页面的主视图
  attachContentWeidget(BuildContext context);

  attachLoaingWeidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    );
  }

  showLoading() async {
    setState(() {
      _isShowNetworkError = false;
      _isShowContent = false;
      _isShowEmpty = false;
      _isShowLoading = true;
    });
  }

  showContent() async {
    setState(() {
      _isShowNetworkError = false;
      _isShowContent = true;
      _isShowEmpty = false;
      _isShowLoading = false;
    });
  }

  showEmpty() async {
    setState(() {
      _isShowNetworkError = false;
      _isShowContent = false;
      _isShowEmpty = true;
      _isShowLoading = false;
    });
  }

  showNetworkError() async {
    setState(() {
      _isShowNetworkError = true;
      _isShowContent = false;
      _isShowEmpty = false;
      _isShowLoading = false;
    });
  }
}
