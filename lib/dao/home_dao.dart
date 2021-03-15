import 'package:college_books/model/home_model.dart';
import 'package:college_books/utils/http_utils.dart';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var res = await HttpUtils.request('/home');
    return HomeModel.fromJson(res);
  }
}