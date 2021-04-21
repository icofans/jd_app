import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.blue[100],
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text("side"),
    );
  }
}
