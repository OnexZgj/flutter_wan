import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/api/apis_services.dart';
import 'package:flutter_wan/common/common.dart';
import 'package:flutter_wan/model/wx_artical_item.dart';
import 'package:flutter_wan/ui/weidget/ItemWechartWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WxArticalPageItem extends StatefulWidget {
  final int id;

  WxArticalPageItem(this.id);

  @override
  State<StatefulWidget> createState() {
    return new WxArticalPageItemStates();
  }
}

class WxArticalPageItemStates extends State<WxArticalPageItem> with AutomaticKeepAliveClientMixin {
  int _page = 1;

  List<WxArticalBean> _wxArticalList = new List();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWxArticleList();
  }


  Future getWxArticleList() async {
    _page = 1;
    int _id = widget.id;
    debugPrint("_id $_id");
    apiService.getWxArticalList((WxArticalItemModel response) {
      if (response.errorCode == Constants.STATUS_SUCCESS) {
        _refreshController.refreshCompleted(resetFooterState: true);
        setState(() {
          _wxArticalList.clear();
          _wxArticalList.addAll(response.data.datas);
        });
      }
    }, (DioError error) {

    },_id, _page);
  }


  Future getWxArticleMoreList() async {
    _page ++;
    int _id = widget.id;
    debugPrint("_id $_id");
    apiService.getWxArticalList((WxArticalItemModel response) {
      if (response.errorCode == Constants.STATUS_SUCCESS) {
        _refreshController.loadComplete();
        setState(() {
          _wxArticalList.addAll(response.data.datas);
        });
      }
    }, (DioError error) {

    },_id, _page);
  }


  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: getWxArticleList,
        onLoading: getWxArticleMoreList,
        header: MaterialClassicHeader(),
        child: ListView.builder(itemBuilder: itemView,itemCount: _wxArticalList.length,),
        controller: _refreshController,
      ),
    );
  }

  Widget itemView(BuildContext context, int index) {
    var wxArticalBean = _wxArticalList[index];
    return ItemArticalWidget(item: wxArticalBean);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
