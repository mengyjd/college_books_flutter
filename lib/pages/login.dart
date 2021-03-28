import 'package:college_books/pages/register.dart';
import 'package:college_books/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<LoginPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String username;
  String password;
  bool isShowPassWord = false;

  void login() {
    // TODO: 登录
    if(!loginKey.currentState.validate()) {
      print('验证失败');
      return;
    }
    print('登录==========');
    Utils.showSnackBar(context, '登录');
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '登录表单',
      home: new Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                buildLogo(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new Form(
                    key: loginKey,
                    child: Column(
                      children: [
                        // 输入框
                        ...buildInput(),
                        // 登录按钮
                        new Container(
                          height: 45.0,
                          margin: EdgeInsets.only(top: 40.0),
                          child: new SizedBox.expand(
                            child: new RaisedButton(
                              onPressed: login,
                              color: Color.fromARGB(255, 61, 203, 128),
                              child: new Text(
                                '登录',
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
                        // 注册帐号按钮
                        new Container(
                          margin: EdgeInsets.only(top: 30.0),
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                  },
                                  child: Text(
                                    '注册账号',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color.fromARGB(255, 53, 53, 53)),
                                  ),
                                ),
                              ),

                              /*Text(
                              '忘记密码？',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 53, 53, 53)
                              ),
                            ),*/
                            ],
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
      ),
    );
  }

  Widget buildLogo() {
    return Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
        child: Text(
          'logo',
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
        child: new TextFormField(
          validator: (value) {
            return Utils.validateEmpty(value, '密码');
          },
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          decoration: new InputDecoration(
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
    ];
  }
}
