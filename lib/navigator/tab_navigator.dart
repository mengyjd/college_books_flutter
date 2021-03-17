import 'package:college_books/pages/home/home.dart';
import 'package:college_books/pages/my/my.dart';
import 'package:college_books/pages/publish/publish.dart';
import 'package:college_books/pages/test.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _controller = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), PublishPage(), MyPage(), TestPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedItemColor: _defaultColor,
          selectedItemColor: _activeColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(label: '首页', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: '发布', icon: Icon(Icons.add_box_rounded)),
            BottomNavigationBarItem(label: '我的', icon: Icon(Icons.person_pin)),
            BottomNavigationBarItem(label: 'test', icon: Icon(Icons.category)),
          ],
        onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
        },
      ),
    );
  }
}
