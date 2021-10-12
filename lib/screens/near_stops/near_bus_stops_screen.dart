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
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent.withOpacity(0.6),
                Colors.deepPurpleAccent.withOpacity(0.4),
              ],
            ),
          ),
        ),
        title: Text('Bus Stops Near You',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: NearBusStopsView(showAll: true),
    );
  }
}
