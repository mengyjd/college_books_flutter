import 'package:college_books/dao/home_dao.dart';
import 'package:college_books/model/home_model.dart';
import 'package:college_books/model/publish_goods_model.dart';
import 'package:college_books/pages/publish/image_picker.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:college_books/widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {

  // 选择的分类
  CategoryModel selectedCategory = CategoryModel(id: '0', name: '必选, 请选择');
  List<CategoryModel> categories = []; // 分类列表
  int goodsNum = 1; // 发布的商品数量
  PublishGoodsModel publishGoods = PublishGoodsModel();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('发布图书'),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#f0f0f0')),
        child: ListView(children: [
          _buildForm(),
          // 发布按钮
          _publishBtn(),
        ]),
      ),
    );
  }

  // 获取发布图书的分类
  void getCategories() async {
    categories = await HomeDao.categories();
  }

  // 点击选择分类
  void onTapCategory() {
    showModalBottomSheet(
        context: context, builder: (context) => _buildBottomSheet(context));
  }

  // 修改商品数量, +1 或 -1
  void operateGoodsNum(String type) {
    if (goodsNum >= 999 && type == 'add') {
      return;
    } else if (goodsNum <= 1 && type == 'minus') {
      return;
    }
    setState(() {
      type == 'add' ? goodsNum++ : goodsNum--;
      publishGoods.num = goodsNum;
    });
  }

  void clickPublishBtn() {
    if(!_validateForm()) {
      return;
    }
    print('publishGoods=${publishGoods.toJson()}');
    submit();
  }

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(MyWidget.buildSnackBar('提交'));
  }

  bool _validateForm() {
    if (publishGoods.title == null || publishGoods.title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(MyWidget.buildSnackBar("请填写标题"));
      return false;
    }
    if (publishGoods.price == null || publishGoods.price == 0) {
      ScaffoldMessenger.of(context).showSnackBar(MyWidget.buildSnackBar("请填写价格"));
      return false;
    }
    return true;
  }

  Widget _buildForm() {
    return Form(
      child: Container(
        decoration: BoxDecoration(color: HexColor('#ffffff')),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ..._fromTextInput(),
            // 图片选择组件
            ImagePicker(totalSelectImg: 6,),
            // 分割条
            Container(
              height: 15,
              color: HexColor('#f0f0f0'),
            ),
            // 售卖信息
            _sellInfo(),
          ],
        ),
      ),
    );
  }

  // 标题设详细描述input
  List<Widget> _fromTextInput() {
    return [
      // 标题输入框
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              publishGoods.title = value;
            });
          },
          maxLines: 1,
          decoration: InputDecoration(hintText: '请输入标题'),
        ),
      ),
      // 详细描述输入框
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              publishGoods.desc = value;
            });
          },
          maxLines: 4,
          decoration:
              InputDecoration(hintText: '请输入详细描述', border: InputBorder.none),
        ),
      ),
    ];
  }

  // 售卖信息
  Widget _sellInfo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          // 价格, 原价
          _priceTail(),
          Divider(),
          // 分类
          _categoryTail(),
          Divider(),
          // 数量
          _numTail(),
        ],
      ),
    );
  }

  // 价格原价条目
  Widget _priceTail() {
    return Container(
      height: 50,
      child: Row(
        children: [_priceInput('价格', 100.99), _priceInput('原价', 900.9)],
      ),
    );
  }

  // 价格input
  Widget _priceInput(String title, double price) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                onChanged: (value) {
                  if(value == '' || value == null) {
                    value = '0';
                  }
                  setState(() {
                    if(title == '价格') {
                      publishGoods.price = double.parse(value);
                    } else {
                      publishGoods.originalPrice = double.parse(value);
                    }
                  });
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: HexColor('#ed1010'),
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: '￥ 0.00',
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 分类条目
  Widget _categoryTail() {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("分类", style: TextStyle(fontSize: 16)),
          InkWell(
            onTap: () {
              onTapCategory();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${selectedCategory.name}",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 数量条目
  Widget _numTail() {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("数量", style: TextStyle(fontSize: 16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () => operateGoodsNum('minus'),
                  child: Icon(Icons.remove, color: Colors.grey)),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                alignment: Alignment.center,
                width: 40,
                height: 25,
                color: HexColor('#ebebeb'),
                child: Text("$goodsNum"),
              ),
              InkWell(
                  onTap: () => operateGoodsNum('add'),
                  child: Icon(Icons.add, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
      height: 300,
      color: Colors.white,
      child: ListView(
        children: [
          Wrap(
            spacing: 10,
            children: categories.map((item) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    selectedCategory = item;
                    publishGoods.category = item;
                  });
                },
                child: Text(
                  item.name,
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
    );
  }

  Widget _publishBtn() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: MaterialButton(
          height: 40,
          elevation: 0,
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.white,
          padding: EdgeInsets.all(12),
          child: Text("发布", style: TextStyle(fontSize: 16)),
          onPressed: () => clickPublishBtn()),
    );
  }
}
