import 'package:college_books/model/home_model.dart';

class PublishGoodsModel {
  String title;
  String desc;
  double price;
  double originalPrice;
  int num;
  CategoryModel category;

  PublishGoodsModel(
      {this.title,
        this.desc,
        this.price,
        this.originalPrice,
        this.num,
        this.category});

  PublishGoodsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    num = json['num'];
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['num'] = this.num;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}
