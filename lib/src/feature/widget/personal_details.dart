import 'package:flutter/material.dart';
import 'package:tinder/src/utils/hex_color.dart';

class TabInfo extends StatelessWidget {
  String title;
  String content;

  TabInfo(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: HexColor("#a3a3a3")),
        ),
        subtitle: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
    );
  }
}
