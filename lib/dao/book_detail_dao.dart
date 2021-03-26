
import 'package:college_books/model/book_detail_model.dart';
import 'package:college_books/utils/http_utils.dart';

class BookDetailDao {
  static Future<BookDetailModel> fetch() async {
    var res = await HttpUtils.request('/categories');
    return BookDetailModel.fromJson(res);
  }
}