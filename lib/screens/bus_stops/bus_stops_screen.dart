import 'package:flutter/material.dart';
import 'package:my_bus/screens/home/widgets/bus_stops_view.dart';

class BusStopsScreen extends StatelessWidget {
  static const id = 'busstops';
  static Route route() => MaterialPageRoute(
        builder: (context) => const BusStopsScreen(),
        settings: const RouteSettings(name: BusStopsScreen.id),
      );
  const BusStopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bus Stops')),
      body: BusStopsView(),
    );
  }
}
