import 'package:flutter/material.dart';

class BusStopGuideScreen extends StatelessWidget {
  static const id = 'busstopguide';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: BusStopGuideScreen.id),
        builder: (context) => BusStopGuideScreen(),
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
