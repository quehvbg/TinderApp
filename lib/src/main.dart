import 'package:flutter/material.dart';
import 'package:tinder/src/feature/media/media_favorite_view.dart';
import 'package:tinder/src/feature/media/media_view.dart';

void main() => runApp(TinderApp());

final routes = {
  '/': (BuildContext context) => new MediaPage(),
  '/favorite': (BuildContext context) => new FavoritePage(),
};

class TinderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder',
      routes: routes,
      initialRoute: '/',
    );
  }
}