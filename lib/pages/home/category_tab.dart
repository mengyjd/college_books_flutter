import 'package:college_books/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CategoryTab extends StatefulWidget {
  List<CategoryModel> categories;

  CategoryTab({Key key,List<CategoryModel> categories}): super(key: key){
    this.categories = categories;
  }

  @override
  _CategoryTab createState() => _CategoryTab();
}

class _CategoryTab extends State<CategoryTab> {
  // tabs数据
  bool _tabIsExpand = false; // tab面板是否展开
  final _defaultColor = Colors.grey; // 未选中的tab字体颜色
  final _activeColor = Colors.blue; // 选中的tab字体颜色
  CategoryModel allTab = CategoryModel(id: "0", name: "全部"); // "全部"分类的tab
  String currentSelectTab; // 当前选中的tab

  @override
  void initState() {
    super.initState();
    widget.categories.insert(0, allTab);
    currentSelectTab = allTab.id;
  }

  void clickTabItem(CategoryModel category) {
    setState(() {
      currentSelectTab = category.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index, isExpand) {
        setState(() {
          _tabIsExpand = !_tabIsExpand;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _tabIsExpand,
          headerBuilder: (context, isExpanded) {
            return scrollTab();
          },
          body: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 8,
              children: generateTabs('expand'),
            ),
          ),
        )
      ],
    );
  }

  Widget scrollTab() {
    return Container(
      height: 50,
      child:
          ListView(scrollDirection: Axis.horizontal, children: generateTabs('common')),
    );
  }

  List<Widget> generateTabs(String type) {
    return widget.categories.map((category) {
      if (type == 'common') {
        return tabItem(category);
      } else if (type == 'expand'){
        return expandTabItem(category);
      } else {
        throw "方法generateTabs 参数type错误, 请传入 'common' 或 'expand' ";
      }
    }).toList();
  }

  Widget tabItem(CategoryModel category) {
    return InkWell(
      onTap: () {
        clickTabItem(category);
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Text(
            category.name,
            style: TextStyle(
              color: category.id == currentSelectTab ? _activeColor : _defaultColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }

  Widget expandTabItem(CategoryModel category) {
    return InkWell(
      onTap: () {
        clickTabItem(category);
      },
      child: Container(
        width: 110,
        padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: currentSelectTab == category.id ? _activeColor : _defaultColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: currentSelectTab == category.id ? _activeColor : Colors.white,
        ),
        child: Text(
          category.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: currentSelectTab == category.id ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
