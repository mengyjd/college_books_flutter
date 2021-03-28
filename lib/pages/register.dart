import 'package:college_books/utils/utils.dart';
import 'package:college_books/widget/my_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<RegisterPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> registerKey = new GlobalKey<FormState>();
  String username;
  String password;
  String secondPassword;
  bool isShowPassWord = false;

  void register() {
    // TODO: 注册
    if(!registerKey.currentState.validate()) {
      print('验证失败');
      return;
    }
    if(password != secondPassword) {
      Utils.showSnackBar(context, '两次输入的密码不一致!');
      return;
    }
    print('注册==========');
    Utils.showSnackBar(context, '注册');
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                buildLogo(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new Form(
                    key: registerKey,
                    child: Column(
                      children: [
                        // 输入框
                        ...buildInput(),
                        // 注册按钮
                        new Container(
                          height: 45.0,
                          margin: EdgeInsets.only(top: 40.0),
                          child: new SizedBox.expand(
                            child: new RaisedButton(
                              onPressed: register,
                              color: Color.fromARGB(255, 61, 203, 128),
                              child: new Text(
                                '注册',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(45.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
    );
  }

  Widget buildLogo() {
    return Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
        child: Text(
          '注册帐号',
          style:
          TextStyle(color: Color.fromARGB(255, 53, 53, 53), fontSize: 45.0),
        ));
  }

  List<Widget> buildInput() {
    return [
      new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
        child: new TextFormField(
          validator: (value) {
            return Utils.validateEmpty(value, '用户名');
          },
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
          decoration: new InputDecoration(
            labelText: '请输入用户名',
            labelStyle: new TextStyle(
                fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
        ),
      ),
      new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
        child: TextFormField(
          validator: (value) {
            return Utils.validateEmpty(value, '密码');
          },
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          decoration: InputDecoration(
              labelText: '请输入密码',
              labelStyle: new TextStyle(
                  fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
              border: InputBorder.none,
              suffixIcon: new IconButton(
                icon: new Icon(
                  isShowPassWord ? Icons.visibility : Icons.visibility_off,
                  color: Color.fromARGB(255, 126, 126, 126),
                ),
                onPressed: showPassWord,
              )),
          obscureText: !isShowPassWord,
        ),
      ),
      new Container(
        decoration: new BoxDecoration(
            border: new Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
        child: TextFormField(
          validator: (value) {
            return Utils.validateEmpty(value, '密码');
          },
          onChanged: (value) {
            setState(() {
              secondPassword = value;
            });
          },
          decoration: InputDecoration(
              labelText: '请再次输入密码',
              labelStyle: new TextStyle(
                  fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
              border: InputBorder.none,
              suffixIcon: new IconButton(
                icon: new Icon(
                  isShowPassWord ? Icons.visibility : Icons.visibility_off,
                  color: Color.fromARGB(255, 126, 126, 126),
                ),
                onPressed: showPassWord,
              )),
          obscureText: !isShowPassWord,
        ),
      ),
    ];
  }
}
