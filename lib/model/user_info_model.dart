class UserInfo {
  String username;
  String userId;
  String avatar;

  UserInfo({this.username, this.userId, this.avatar});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['userId'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['avatar'] = this.avatar;
    return data;
  }
}
