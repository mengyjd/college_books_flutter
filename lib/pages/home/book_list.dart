import 'package:college_books/model/home_model.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookList extends StatefulWidget {
  List<BookModel> bookList;

  BookList({
    Key key,
    this.bookList,
  }) : super(key: key);

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
          children: widget.bookList.map((item) {
            return bookCard(item);
          }).toList(),
        ),
      ),
    );
  }

  Widget bookCard(BookModel book) {
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
            book.cover,
            width: cardWidth,
            height: 175,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
            child: Text(
              book.name,
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
              '￥${book.price}',
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
