import 'package:flutter/material.dart';
import 'package:my_bus/screens/home/widgets/near_busstop_view.dart';

class NearBusStopsScreen extends StatelessWidget {
  static const id = 'nearbusstopsscreen';
  static Route route() => MaterialPageRoute(
        builder: (context) => NearBusStopsScreen(),
        settings: RouteSettings(name: NearBusStopsScreen.id),
      );
  const NearBusStopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Stops Near You'),
      ),
      body: NearBusStopsView(showAll: true),
    );
  }
}
