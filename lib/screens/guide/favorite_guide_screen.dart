import 'package:flutter/material.dart';

class FavoriteGuideScreen extends StatelessWidget {
  static const id = 'favoriteguide';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: FavoriteGuideScreen.id),
        builder: (context) => FavoriteGuideScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [],
      ),
    );
  }
}
