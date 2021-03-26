import 'package:college_books/model/book_detail_model.dart';
import 'package:college_books/model/home_model.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  BookDetailModel _bookDetail;

  @override
  void initState() {
    super.initState();
    getBookDetailData();
  }

  void getBookDetailData() {
    _bookDetail = BookDetailModel(
        bookId: '1',
        avatar: 'https://www.hualigs.cn/image/605b1091dae8c.jpg',
        username: '梦萦几度',
        price: 199.00,
        originalPrice: 399.99,
        title: '星火英语卷子',
        desc: '星火英语四级真题卷子, 包含2019年6月3套真题卷',
        images: [
          "https://www.hualigs.cn/image/604b78d0596a1.jpg",
          "https://www.hualigs.cn/image/604b78b2267bf.jpg",
          "https://www.hualigs.cn/image/604b78d059dde.jpg",
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "详情",
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.shopping_cart_outlined),
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ListView(
          children: [
            userInfoWidget(),
            Divider(height: 1),
            // 价格信息组件
            priceWidget(),
            // 描述信息组件, 包括title和desc
            descWidget(),
            // 图片列表
            imgsWidget(),
          ],
        ),
      ),
    );
  }

  Widget userInfoWidget() {
    return Container(
        child: ListTile(
      leading: Image.network(
        _bookDetail.avatar,
        width: 30,
        height: 40,
      ),
      title: Text(_bookDetail.username),
      // subtitle: Text(_bookDetail.desc),
    ));
  }

  Widget priceWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Text(
            "￥${_bookDetail.price.toString()}",
            style: TextStyle(
              fontSize: 20,
              color: HexColor("#f2605f"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Text(
              "￥${_bookDetail.originalPrice.toString()}",
              style: TextStyle(
                fontSize: 15,
                color: HexColor("#979797"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: HexColor("#f2605f"),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text(
              "不讲价",
              style: TextStyle(
                fontSize: 12,
                color: HexColor("#ffffff"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget descWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _bookDetail.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_bookDetail.desc),
        ],
      ),
    );
  }

  Widget imgsWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: _bookDetail.images.map((imgUrl) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: PhysicalModel(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.network(imgUrl),
            ),
          );
        }).toList(),
      ),
    );
  }
}
