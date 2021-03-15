import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [head(), menuList()],
      ),
    );
  }

  // 头像区域
  Widget head() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/my_bg.jpg'),
        fit: BoxFit.cover,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/txz.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "梦萦几度",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  // 菜单列表
  Widget menuList() {
    return Column(
      children: [
        ListTile(
          leading: Image.asset('assets/images/order_query.png', width: 30, height: 40,),
          title: Text("订单查询"),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
        ),
        Divider(),
        ListTile(
          leading: Image.asset('assets/images/about.png', width: 30, height: 40,),
          title: Text("关于软件"),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
        ),
        Divider(),
        ListTile(
          leading: Image.asset('assets/images/share.png', width: 30, height: 40,),
          title: Text("好用分享"),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
        ),
        Divider(),
      ],
    );
  }
}
