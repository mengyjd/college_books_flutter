import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool opened = false;
  List<Map<String, String>> categories = [
    {"id": "1", 'name': "计算机科学与工程学"},
    {"id": "2", "name": "金融"},
    {"id": "3", "name": "统计与信息"},
    {"id": "4", "name": "工商管理"},
    {"id": "5", "name": "会计"},
    {"id": "6", "name": "外语"}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
            color: Colors.blue,
            onPressed: () {
              opened = !opened;
              opened
                  ? Scaffold.of(context)
                      .showBottomSheet((_) => _buildBottomSheet2())
                  : Navigator.of(context).pop();
            },
            child: Text(
              '点我显隐BottomSheet',
              style: TextStyle(color: Colors.white),
            )));
  }

  Widget _buildBottomSheet2() => BottomSheet(
        enableDrag: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onClosing: () => print('onClosing'),
        builder: (_) => (Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
          height: 300,
          color: Colors.white,
          child: ListView(
            children: [
              Wrap(
                spacing: 10,
                children: categories.map((item) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        )),
      );
}
