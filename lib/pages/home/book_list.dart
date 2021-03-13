import 'package:college_books/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookList extends StatefulWidget {
  @override
  _BookList createState() => _BookList();
}

class _BookList extends State<BookList> {
  final List books = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 7,
          runSpacing: 7,
          children: books.map((item) {
            return bookCard();
          }).toList(),
        ),
      ),
    );
  }

  Widget bookCard() {
    final double cardWidth = 160;
    return Container(
      width: cardWidth,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            'https://www.hualigs.cn/image/604b78c9d35d2.jpg',
            width: cardWidth,
            height: 175,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
            child: Text(
              'Java高级',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
            child: Text(
              '￥135.99',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: HexColor('#d1470d'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
