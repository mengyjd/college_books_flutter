import 'package:college_books/dao/home_dao.dart';
import 'package:college_books/model/home_model.dart';
import 'package:college_books/model/publish_goods_model.dart';
import 'package:college_books/utils/empty_widget.dart';
import 'package:college_books/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {
  List<Asset> images = []; // 选择的图片列表
  String _error;
  final int totalSelectImg = 6; // 最多可选择的图片数量
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

  void getCategories() async {
    categories = await HomeDao.categories();
  }

  // 点击列表图片
  void onTapImg(Asset asset, int index) {
    // TODO: 后续版本更新功能: 放大查看图片
    print("onTapImg=$asset, $index");
  }

  // 点击删除列表中的删除按钮, 从列表中删除该图片
  void onTapDelete(Asset asset, int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  // 点击选择分类
  void onTapCategory() {
    showModalBottomSheet(
        context: context, builder: (context) => _buildBottomSheet(context));
  }

  // 选择图片
  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: totalSelectImg - images.length,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarTitle: "选择图片",
          allViewTitle: "请选择图片",
          selectionLimitReachedText: "最多添加$totalSelectImg张图片哦",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = [...images, ...resultList];
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar("图片选择器错误"));
        print("multi_image_picker发生了错误: $_error");
      }
    });
  }

  updateLoadImg(Asset asset) {

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

    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar("通过"));
  }

  bool _validateForm() {
    if (publishGoods.title == null || publishGoods.title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar("请填写标题"));
      return false;
    }
    if (publishGoods.price == null || publishGoods.price == 0) {
      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar("请填写价格"));
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
            // 图片上传list
            _buildImgList(),
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

  // 图片列表
  Widget _buildImgList() {
    if (images != null) {
      // 用户选择的图片列表
      List<Widget> selectedImgList = List.generate(images.length, (index) {
        Asset asset = images[index];
        return _addedImgWidget(asset, index);
      });
      Widget tailWidget =
          images.length >= totalSelectImg ? EmptyWidget() : _addImgWidget();
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [...selectedImgList, tailWidget],
        ),
      );
    } else {
      return _addImgWidget();
    }
  }

  // 已添加到列表的图片组件
  Widget _addedImgWidget(Asset asset, int index) {
    return InkWell(
      onTap: () {
        onTapImg(asset, index);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          AssetThumb(
            asset: asset,
            width: 100,
            height: 100,
          ),
          // 从列表删除图片Icon
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                onTapDelete(asset, index);
              },
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          // 图片上传进度条
          Container(
            width: 80,
            child: LinearProgressIndicator(
              value: .5,
            ),
          ),
        ],
      ),
    );
  }

  // 添加图片按钮
  Widget _addImgWidget() {
    return InkWell(
      onTap: loadAssets,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        color: HexColor('#f1f1f1'),
        child: Icon(
          Icons.add,
          color: HexColor('#d6d6d6'),
          size: 30,
        ),
      ),
    );
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

  Widget _buildSnackBar(String text) {
    return SnackBar(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text(text),
      duration: Duration(seconds: 3),
      //持续时间
      backgroundColor: Colors.red,
      onVisible: () => print('onVisible'),
      action: SnackBarAction(
          textColor: Colors.white, label: '确定', onPressed: () {}),
    );
  }
}
