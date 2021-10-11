import 'package:flutter/material.dart';
import 'package:my_bus/screens/screens.dart';
import 'package:my_bus/widgets/bus_arrival_widget.dart';

class CustomRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return SplashScreen.route();
      case HomeScreen.id:
        return HomeScreen.route();
      case LocationEnableScreen.id:
        return LocationEnableScreen.route();
      case BusArrivalWidget.id:
        return BusArrivalWidget.route();
      case BusServiceScreen.id:
        return BusServiceScreen.route();
      case BusStopsScreen.id:
        return BusStopsScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
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
