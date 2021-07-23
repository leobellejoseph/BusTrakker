import 'package:flutter/material.dart';
import 'package:my_bus/screens/screens.dart';

class CustomRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return SplashScreen.route();
      case HomeScreen.id:
        return HomeScreen.route();
      case LocationEnableScreen.id:
        return LocationEnableScreen.route();
      default:
        return _erorrRoute();
    }
  }

  static Route _erorrRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
