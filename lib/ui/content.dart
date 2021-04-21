import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'list_item.dart';

class Content extends StatefulWidget {
  Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  TabController tabController;

  ScrollController _controller = ScrollController();
  List keys = [];
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
    }
  ];

  double fillY;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: datas.length, vsync: this);
    for (var i = 0; i < datas.length; i++) {
      keys.add(GlobalKey(debugLabel: i.toString()));
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      double offsetY = getOffset(keys[0]).dy;

      final RenderBox box =
          keys[datas.length - 1].currentContext.findRenderObject();

      print(offsetY);
      print(box.size.height);
      setState(() {
        fillY = box.size.height + offsetY;
      });
    });
  }

  void onChangeIndex(int index) {
    print("点击了" + index.toString());

    try {
      double offsetY = getOffset(keys[0]).dy;

      double y = getOffset(keys[index]).dy;
      print("offsetY = $offsetY");
      print("Y = $y");
      _controller.position
          .moveTo(y - offsetY, duration: Duration(milliseconds: 200));
    } catch (e) {
      // _controller.jumpTo(0);
      // onChangeIndex(index);
    }
    // _controller.animateTo(y - offsetY,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.fastLinearToSlowEaseIn);
  }

  Offset getOffset(GlobalKey key) {
    final RenderBox box = key.currentContext.findRenderObject();
    //final size = box.size;
    final position = box.localToGlobal(Offset.zero);
    return position;
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
            TabBar(
              tabs: datas.map((e) {
                return Tab(
                  child: Text(e["title"]),
                );
              }).toList(),
              controller: tabController,
              onTap: (index) {
                onChangeIndex(index);
                switch (index) {
                  case 0:
                    tabController.animateTo(0);
                    break;
                  case 1:
                    tabController.animateTo(1);
                    break;
                  case 2:
                    tabController.animateTo(2);
                    break;
                }
              },
            ),
            Expanded(
              child: Container(
                color: Colors.green[100],
                child: ListView.builder(
                  // + 1 为了滚动
                  itemCount: datas.length + 1,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    print(index);
                    if (index <= datas.length - 1) {
                      Map item = datas[index];
                      return ListItem(
                        key: keys[index],
                        title: item["title"],
                        items: item["items"],
                      );
                    } else {
                      // + 一屏高度... 不一定合理
                      final size = MediaQuery.of(context).size;
                      final height = size.height;
                      return Container(
                        height: fillY != null ? height - fillY : height / 2,
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
