import 'package:flutter/material.dart';
import 'package:jd_app/ui/content.dart';
import 'package:jd_app/ui/sidebar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        child: Row(
          children: [
            Sidebar(),
            Content(),
          ],
        ),
      ),
    );
  }
}
