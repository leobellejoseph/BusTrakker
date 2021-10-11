import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class BusStopsScreen extends StatelessWidget {
  static const id = 'busstops';
  static Route route() => MaterialPageRoute(
        builder: (context) => BusStopsScreen(),
        settings: const RouteSettings(name: BusStopsScreen.id),
      );
  final controller = TextEditingController();
  BusStopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.6),
                Colors.blue.withOpacity(0.2),
              ],
            ),
          ),
        ),
        title: TextFormField(
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey.shade700,
              fontSize: 20),
          controller: controller,
          showCursor: true,
          cursorColor: Colors.blueAccent.shade700,
          decoration: InputDecoration(
              hintText: 'Bus Stops',
              hintStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        actions: [
          IconButton(
              icon: Icon(
                CupertinoIcons.search,
                color: Colors.blue.shade900,
                size: 30,
              ),
              onPressed: () {
                context.read<BusDataBloc>().add(BusStopFetch(controller.text));
              }),
          const SizedBox(width: 10),
        ],
      ),
      body: BusStopsView(),
    );
  }
}
