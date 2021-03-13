import 'package:college_books/pages/home/book_list.dart';
import 'package:college_books/pages/home/category_tab.dart';
import 'package:college_books/pages/home/my_appbar.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const int APPBAR_SCROLL_OFFSET = 100; // 当ListView滚动到100时appbar为不透明

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List _imgUrls = [
    'https://www.hualigs.cn/image/604b78b2267bf.jpg',
    'https://ae01.alicdn.com/kf/U7e68a90fa338497791d80f2d1ef691d5H.jpg',
    'https://www.hualigs.cn/image/604b78c9d35d2.jpg',
  ];
  double _appbarOpacity = 0;

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
    return Scaffold(
      body: Stack(
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
                    homeBanner(),
                    CategoryTab(),
                    BookList(),
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
    );
  }

  // 轮播图
  Widget homeBanner() {
    return Container(
      height: 170,
      child: Swiper(
        itemCount: _imgUrls.length,
        autoplay: true,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(_imgUrls[index], fit: BoxFit.fill);
        },
      ),
    );
  }
}
