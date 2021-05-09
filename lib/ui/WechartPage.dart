import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/api/apis_services.dart';
import 'package:flutter_wan/common/common.dart';
import 'package:flutter_wan/model/wx_chapter_model.dart';
import 'package:flutter_wan/ui/base/BaseWidget.dart';

import 'WechartPageItem.dart';

class WechartPage extends BaseWidget {
  @override
  BaseWeidgetState<BaseWidget> createBaseState() {
    return WechartPageState();
  }
}

class WechartPageState extends BaseWeidgetState<WechartPage>
    with TickerProviderStateMixin {
  //请求重绘的时候
  List<WxChaptersBean> _chaptersList = new List();

  TabController _tabController;

  @override
  void didChangeDependencies() {
    showLoading().then((value) => getWxChaptersList());
  }

  @override
  attachContentWeidget(BuildContext context) {
    _tabController =
        new TabController(length: _chaptersList.length, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            child: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(color: Colors.deepPurple, fontSize: 16),
                labelColor: Colors.deepPurple,
                indicatorColor: Colors.purpleAccent,
                controller: _tabController,
                tabs: _chaptersList.map((WxChaptersBean item) {
                  debugPrint(item.name);
                  return Tab(text: item.name);
                }).toList()),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                  children: _chaptersList.map((WxChaptersBean item) {
            return WxArticalPageItem(item.id);
          }).toList())),
        ],
      ),
    );
  }


  Future getWxChaptersList() async {
    apiService.getWXChaptersList((WxChapterModel wxChapterModel) {
      if (wxChapterModel.errorCode == Constants.STATUS_SUCCESS) {
        if (wxChapterModel.data.length > 0) {
          showContent();
          setState(() {
            _chaptersList.clear();
            _chaptersList.addAll(wxChapterModel.data);
          });
        }
      }
    }, (DioError e) {});
  }

  @override
  void onClickErrorWidget() {
    getWxChaptersList();
  }
}
