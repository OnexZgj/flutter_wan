import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/api/apis_services.dart';
import 'package:flutter_wan/common/common.dart';
import 'package:flutter_wan/model/project_tree_model.dart';
import 'package:flutter_wan/ui/base/BaseWidget.dart';

class ProjectPage extends BaseWidget {
  @override
  BaseWeidgetState<BaseWidget> createBaseState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends BaseWeidgetState with TickerProviderStateMixin {
  @override
  void initState() {}

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    showLoading().then((value) => getProjectTreeList());
  }

  TabController _tabController;

  @override
  attachContentWeidget(BuildContext context) {
    _tabController =
    new TabController(length: _projectTreeList.length, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            child: TabBar(
                controller: _tabController,
                labelColor: Colors.cyan,
                isScrollable: true,
                tabs: _projectTreeList.map((item) {
                  return Tab(text :item.name);
                }).toList()
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: _projectTreeList.map((item) {
                    // return ProjectArticleItem(item.id);
                    return ProjectArticleItem();
                  }).toList()))
        ],
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    getProjectTreeList();
  }

  List<ProjectTreeBean> _projectTreeList = new List();

  Future getProjectTreeList() async {
    apiService.getProjectTreeList((ProjectTreeModel projectTreeModel) {
      if (projectTreeModel.errorCode == Constants.STATUS_SUCCESS) {
        if (projectTreeModel.data.length > 0) {
          showContent();
          setState(() {
            _projectTreeList.clear();
            _projectTreeList = projectTreeModel.data;
          });
        } else {
          showEmpty();
        }
      }
    }, (DioError error) {
      showNetworkError();
    });
  }
}


class ProjectArticleItem extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    return new ProjectArticleItemState();
  }


}


class ProjectArticleItemState extends State<ProjectArticleItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Text("我定"),
        ),
      ),
    );
  }
}


