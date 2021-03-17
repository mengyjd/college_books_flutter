import 'package:college_books/utils/hex_color.dart';
import 'package:college_books/widget/empty_widget.dart';
import 'package:college_books/widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePicker extends StatefulWidget {
  final int totalSelectImg; // 最多可选择的图片数量

  ImagePicker({Key key, this.totalSelectImg}) :super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<Asset> images = []; // 选择的图片列表

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildImgList();
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

  // 选择图片
  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: widget.totalSelectImg - images.length,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarTitle: "选择图片",
          allViewTitle: "请选择图片",
          selectionLimitReachedText: "最多添加${widget.totalSelectImg}张图片哦",
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
        ScaffoldMessenger.of(context).showSnackBar(MyWidget.buildSnackBar('图片选择器错误',));
        print("multi_image_picker发生了错误: $error");
      }
    });

    print('resultList==${resultList.length}');
    resultList.forEach((img) {
      updateLoadImg(img);
    });
  }

  void updateLoadImg(Asset asset) {
    print('上传图片${asset.name}');
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
      images.length >= widget.totalSelectImg ? EmptyWidget() : _addImgWidget();
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
}

