import 'package:flutter/material.dart';

class ServiceGuideScreen extends StatelessWidget {
  static const id = 'serviceguide';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: ServiceGuideScreen.id),
        builder: (context) => ServiceGuideScreen(),
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
