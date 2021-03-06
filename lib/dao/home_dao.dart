import 'dart:convert';

import 'package:college_books/model/home_model.dart';
import 'package:college_books/utils/http_utils.dart';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var res = await HttpUtils.request('/home');
    return HomeModel.fromJson(res);
  }

  static Future<List<CategoryModel>> categories() async {
    var data = await HttpUtils.request('/categories');
    List<CategoryModel> categoryList = [];
    data['categories'].forEach((category) {
      categoryList.add(CategoryModel.fromJson(category));
    });
    // print('categoryList==${categoryList}');
    return categoryList;
  }
}