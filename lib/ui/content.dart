import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class Content extends StatefulWidget {
  Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  TabController tabController;

  ScrollController _refreshController = ScrollController();

  List datas = [
    {
      "title": "测试1",
      "items": [
        {"title": "商品1", "icon": Icons.home},
        {"title": "商品2", "icon": Icons.dangerous},
        {"title": "商品3", "icon": Icons.data_usage},
        {"title": "商品4", "icon": Icons.face},
      ]
    },
    {
      "title": "测试2",
      "items": [
        {"title": "商品5", "icon": Icons.home},
        {"title": "商品6", "icon": Icons.dangerous},
        {"title": "商品7", "icon": Icons.data_usage},
        {"title": "商品8", "icon": Icons.face},
        {"title": "商品9", "icon": Icons.face},
        {"title": "商品10", "icon": Icons.g_translate},
      ]
    },
    {
      "title": "测试3",
      "items": [
        {"title": "商品35", "icon": Icons.home},
        {"title": "商品46", "icon": Icons.dangerous},
        {"title": "商品57", "icon": Icons.data_usage},
        {"title": "商品68", "icon": Icons.face},
        {"title": "商品79", "icon": Icons.face},
        {"title": "商品80", "icon": Icons.g_translate},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void onChangeIndex(int index) {
    print("点击了" + index.toString());
    _refreshController.position
        .moveTo(200, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        color: Colors.orange[100],
        child: Column(
          children: [
            Row(
              children: datas.map((e) {
                return InkWell(
                  onTap: () => onChangeIndex(datas.indexOf(e)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(e["title"]),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: Container(
                color: Colors.green[100],
                child: ListView.builder(
                  // + 1 为了滚动
                  itemCount: datas.length + 1,
                  controller: _refreshController,
                  itemBuilder: (context, index) {
                    print(index);
                    if (index <= datas.length - 1) {
                      Map item = datas[index];
                      return ListItem(
                        title: item["title"],
                        items: item["items"],
                      );
                    } else {
                      // + 一屏高度... 不一定合理
                      final size = MediaQuery.of(context).size;
                      final height = size.height;
                      return Container(
                        height: height,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
