
class MainBottomPageBean {
  int id;
  String title;
  String alias;
  int sort;
  int status;
  int isFee;
  int jumpType;
  String remark;
  String url;
  String lastEditor;
  int createdAt;
  int updatedAt;

  MainBottomPageBean({
    required this.id,
    required this.title,
    required this.alias,
    required this.sort,
    required this.status,
    required this.isFee,
    required this.jumpType,
    required this.remark,
    required this.url,
    required this.lastEditor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainBottomPageBean.fromJson(Map<String, dynamic> json) => MainBottomPageBean(
    id: json["id"],
    title: json["title"],
    alias: json["alias"],
    sort: json["sort"],
    status: json["status"],
    isFee: json["is_fee"],
    jumpType: json["jump_type"],
    remark: json["remark"],
    url: json["url"],
    lastEditor: json["last_editor"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "alias": alias,
    "sort": sort,
    "status": status,
    "is_fee": isFee,
    "jump_type": jumpType,
    "remark": remark,
    "url": url,
    "last_editor": lastEditor,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
