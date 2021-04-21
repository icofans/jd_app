import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final List items;
  const ListItem({Key key, this.title, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(title ?? ""),
          ],
        ),
        Container(
          // height: 200,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemCount: items.length,
            itemBuilder: (context, index) {
              Map data = items[index];
              return InkWell(
                // onTap: () => onTap?.call(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        data["icon"],
                        size: 52,
                      ),
                      SizedBox(height: 4),
                      Text(
                        data["title"],
                      )
                    ],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
            ),
          ),
        ),
      ],
    );
  }
}
