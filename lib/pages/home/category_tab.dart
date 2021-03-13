import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CategoryTab extends StatefulWidget {
  @override
  _CategoryTab createState() => _CategoryTab();
}

class _CategoryTab extends State<CategoryTab> {
  // tabs数据
  final List categorys = [
    '全部',
    '计算机科学与技术',
    '旅游管理',
    '酒店管理',
    '国际经济与贸易',
    '信息管理与信息系统',
    '物流管理',
    '人力资源管理',
    '物流管理1'
  ];
  bool _tabIsExpand = false; // tab面板是否展开
  final _defaultColor = Colors.grey; // 未选中的tab字体颜色
  final _activeColor = Colors.blue; // 选中的tab字体颜色
  String currentSelectTab = '全部'; // 当前选中的tab

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
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 5,
              children: categorys.map((item) {
                return Container(
                  width: 110,
                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: currentSelectTab == item ? _activeColor : _defaultColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color:
                        currentSelectTab == item ? _activeColor : Colors.white,
                  ),
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: currentSelectTab == item
                            ? Colors.white
                            : Colors.black),
                  ),
                );
              }).toList(),
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
          ListView(scrollDirection: Axis.horizontal, children: generateTabs()),
    );
  }

  List<Widget> generateTabs() {
    return categorys.map((item) {
      return InkWell(
        onTap: () {
          setState(() {
            currentSelectTab = item;
          });
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Text(
              item,
              style: TextStyle(
                color: item == currentSelectTab ? _activeColor : _defaultColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
