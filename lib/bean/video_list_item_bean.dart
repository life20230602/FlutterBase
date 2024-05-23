class VideoListBean {
  List<ListElement> list;
  Page page;
  String amount;
  String validAmount;

  VideoListBean({
    required this.list,
    required this.page,
    required this.amount,
    required this.validAmount,
  });

  factory VideoListBean.fromJson(Map<String, dynamic> json) => VideoListBean(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    page: Page.fromJson(json["page"]),
    amount: json["amount"],
    validAmount: json["valid_amount"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "page": page.toJson(),
    "amount": amount,
    "valid_amount": validAmount,
  };
}

class ListElement {
  int id;
  String salePrice;
  int permissionType;
  String desc;
  String title;
  String horizontalCover;
  int videoLength;
  int favoriteCount;
  int commentCount;
  int upvoteCount;
  int clickCount;
  int uploader;
  int createdAt;
  String uploaderName;
  String uploaderAvatar;
  bool adv;
  String jumpUri;
  int jumpType;
  bool permissions;
  dynamic tags;

  ListElement({
    required this.id,
    required this.salePrice,
    required this.permissionType,
    required this.desc,
    required this.title,
    required this.horizontalCover,
    required this.videoLength,
    required this.favoriteCount,
    required this.commentCount,
    required this.upvoteCount,
    required this.clickCount,
    required this.uploader,
    required this.createdAt,
    required this.uploaderName,
    required this.uploaderAvatar,
    required this.adv,
    required this.jumpUri,
    required this.jumpType,
    required this.permissions,
    required this.tags,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    salePrice: json["sale_price"],
    permissionType: json["permission_type"],
    desc: json["desc"],
    title: json["title"],
    horizontalCover: json["horizontal_cover"],
    videoLength: json["video_length"],
    favoriteCount: json["favorite_count"],
    commentCount: json["comment_count"],
    upvoteCount: json["upvote_count"],
    clickCount: json["click_count"],
    uploader: json["uploader"],
    createdAt: json["created_at"],
    uploaderName: json["uploader_name"],
    uploaderAvatar: json["uploader_avatar"],
    adv: json["adv"],
    jumpUri: json["jump_uri"],
    jumpType: json["jump_type"],
    permissions: json["permissions"],
    tags: json["tags"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_price": salePrice,
    "permission_type": permissionType,
    "desc": desc,
    "title": title,
    "horizontal_cover": horizontalCover,
    "video_length": videoLength,
    "favorite_count": favoriteCount,
    "comment_count": commentCount,
    "upvote_count": upvoteCount,
    "click_count": clickCount,
    "uploader": uploader,
    "created_at": createdAt,
    "uploader_name": uploaderName,
    "uploader_avatar": uploaderAvatar,
    "adv": adv,
    "jump_uri": jumpUri,
    "jump_type": jumpType,
    "permissions": permissions,
    "tags": tags,
  };
}

class Page {
  int total;
  int totalPage;
  int pageSize;
  int currentPage;

  Page({
    required this.total,
    required this.totalPage,
    required this.pageSize,
    required this.currentPage,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    total: json["total"],
    totalPage: json["total_page"],
    pageSize: json["page_size"],
    currentPage: json["current_page"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "total_page": totalPage,
    "page_size": pageSize,
    "current_page": currentPage,
  };
}
