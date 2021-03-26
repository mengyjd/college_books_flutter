class BookDetailModel {
  String bookId;
  String avatar;
  String username;
  double price;
  double originalPrice;
  String title;
  String desc;
  List<String> images;

  BookDetailModel(
      {this.bookId,
        this.avatar,
        this.username,
        this.price,
        this.originalPrice,
        this.title,
        this.desc,
        this.images});

  BookDetailModel.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    avatar = json['avatar'];
    username = json['username'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    title = json['title'];
    desc = json['desc'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['images'] = this.images;
    return data;
  }
}
