class UserInfoBean {
  int uid;
  String token;
  String nick;
  String phoneCode;
  String phoneNumber;
  String devid;
  int status;
  int isGuest;
  String avatar;
  int isNick;
  int anchor;
  int vip;
  String vipName;
  String vipIcon;
  String money;
  String username;
  String inviteCode;
  String personalProfile;
  bool jqPermission;
  int integral;
  int vipExpire;
  String pInviteCode;

  UserInfoBean({
    required this.uid,
    required this.token,
    required this.nick,
    required this.phoneCode,
    required this.phoneNumber,
    required this.devid,
    required this.status,
    required this.isGuest,
    required this.avatar,
    required this.isNick,
    required this.anchor,
    required this.vip,
    required this.vipName,
    required this.vipIcon,
    required this.money,
    required this.username,
    required this.inviteCode,
    required this.personalProfile,
    required this.jqPermission,
    required this.integral,
    required this.vipExpire,
    required this.pInviteCode,
  });

  factory UserInfoBean.fromJson(Map<String, dynamic> json) => UserInfoBean(
    uid: json["uid"],
    token: json["token"],
    nick: json["nick"],
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    devid: json["devid"],
    status: json["status"],
    isGuest: json["is_guest"],
    avatar: json["avatar"],
    isNick: json["is_nick"],
    anchor: json["anchor"],
    vip: json["vip"],
    vipName: json["vip_name"],
    vipIcon: json["vip_icon"],
    money: json["money"],
    username: json["username"],
    inviteCode: json["invite_code"],
    personalProfile: json["personal_profile"],
    jqPermission: json["jq_permission"],
    integral: json["integral"],
    vipExpire: json["vip_expire"],
    pInviteCode: json["p_invite_code"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "token": token,
    "nick": nick,
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "devid": devid,
    "status": status,
    "is_guest": isGuest,
    "avatar": avatar,
    "is_nick": isNick,
    "anchor": anchor,
    "vip": vip,
    "vip_name": vipName,
    "vip_icon": vipIcon,
    "money": money,
    "username": username,
    "invite_code": inviteCode,
    "personal_profile": personalProfile,
    "jq_permission": jqPermission,
    "integral": integral,
    "vip_expire": vipExpire,
    "p_invite_code": pInviteCode,
  };
}
