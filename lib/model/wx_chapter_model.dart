class WxChapterModel {
  List<WxChaptersBean> data;
  int errorCode;
  String errorMsg;

  WxChapterModel({this.data, this.errorCode, this.errorMsg});

  WxChapterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<WxChaptersBean>();
      json['data'].forEach((v) {
        data.add(new WxChaptersBean.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class WxChaptersBean {
  List<dynamic> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  WxChaptersBean(
      {this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible});

  WxChaptersBean.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = new List();
      json['children'].forEach((v) {
        children.add(v);
      });
    }
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['courseId'] = this.courseId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['parentChapterId'] = this.parentChapterId;
    data['userControlSetTop'] = this.userControlSetTop;
    data['visible'] = this.visible;
    return data;
  }
}
