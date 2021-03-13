import 'package:flutter/material.dart';

const double APPBAR_HEIGHT = 90;
const double APPBAR_INPUT_HEIGHT = 35;

class MyAppbar extends StatelessWidget {
  double appbarOpacity;

  MyAppbar({Key key, this.appbarOpacity}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return appbar();
  }

  // 点击appbar中的输入框,进入搜索页面
  void _onTapInput() {
    print('onTabInput');
  }

  // 点击appbar中的条形码扫描图标,进入扫码页面
  void _onTapQrcode() {
    print('onTapQrcode');
  }

  Widget appbarInput() {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: _onTapInput,
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
          height: APPBAR_INPUT_HEIGHT,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              Text(
                  '搜索想要的书籍, 例如: 软件工程',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget appbar() {
    return Opacity(
      opacity: appbarOpacity,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        height: APPBAR_HEIGHT,
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Row(
            children: [
              appbarInput(),
              Expanded(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: _onTapQrcode,
                    child: Icon(Icons.qr_code),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}