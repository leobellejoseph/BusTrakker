import 'package:flutter/material.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class BusServiceScreen extends StatelessWidget {
  static const id = 'service';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: BusServiceScreen.id),
        builder: (context) => const BusServiceScreen(),
      );
  const BusServiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Services'),
      ),
      body: BusServiceView(),
    );
  }
}
