import 'package:college_books/dao/home_dao.dart';
import 'package:college_books/model/home_model.dart';
import 'package:college_books/pages/home/book_list.dart';
import 'package:college_books/pages/home/category_tab.dart';
import 'package:college_books/pages/home/my_appbar.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:college_books/widget/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const int APPBAR_SCROLL_OFFSET = 150; // 当ListView滚动到150时appbar为不透明

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  double _appbarOpacity = 0;

  List _bannerList = [];
  List<BookModel> _bookList = [];
  List<CategoryModel> _categoryList = [CategoryModel(id: "0", name: "全部")];
  bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  void getHomeData() async{
    print("====getHomeDate====");
    setState(() {
      _isLoading = true;
    });
    HomeModel homeModel = await HomeDao.fetch();
    setState(() {
      _bannerList = homeModel.bannerList;
      _bookList = homeModel.bookList;
      _categoryList = homeModel.categoryList;
      _isLoading = false;
    });
  }

  _onScroll(offset) {
    double opacity = offset / APPBAR_SCROLL_OFFSET;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    setState(() {
      _appbarOpacity = opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: NotificationListener(
                onNotification: (sn) {
                  if (sn is ScrollUpdateNotification && sn.depth == 0) {
                    _onScroll(sn.metrics.pixels);
                  }
                  return false;
                },
                child: Container(
                  decoration: BoxDecoration(color: HexColor('#f0f0f0')),
                  child: ListView(
                    children: [
                      homeBanner(_bannerList),
                      CategoryTab(categories: _categoryList),
                      BookList(bookList: _bookList),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Text(
                        '已经到底啦',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            MyAppbar(appbarOpacity: _appbarOpacity),
          ],
        ),
      ),
    );
  }

  // 轮播图
  Widget homeBanner(bannerList) {
    return Container(
      height: 170,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(bannerList[index], fit: BoxFit.fill);
        },
      ),
    );
  }
}
