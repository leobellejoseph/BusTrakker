import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/screens.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusArrivalBanner extends StatelessWidget {
  final String code;
  final String service;
  const BusArrivalBanner({Key? key, required this.code, required this.service})
      : super(key: key);
  void _showRouteSheet(BuildContext context, String service) {
    BusRouteCubit route = context.read<BusRouteCubit>();
    route.fetchRoute(service: service);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 2,
      context: context,
      builder: (context) {
        route.fetchRoute(service: service, code: code);
        return BusRouteScreen(service: service, code: code);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
        content: SafeArea(
          child: SizedBox(
            height: 200,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.lightBlueAccent.withOpacity(0.3),
                  Colors.lightBlueAccent.withOpacity(0.5),
                ]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(service,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                  const Divider(height: 0.4, color: Colors.black54),
                  BusArrivalList(service: service, code: code),
                ],
              ),
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Icon(Icons.arrow_circle_up),
            style: OutlinedButton.styleFrom(
              primary: Colors.blueAccent,
              shape: StadiumBorder(),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Icon(CupertinoIcons.refresh_circled),
            style: OutlinedButton.styleFrom(
              primary: Colors.green,
              shape: StadiumBorder(),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Icon(Icons.favorite),
            style: OutlinedButton.styleFrom(
              primary: Colors.yellow,
              shape: StadiumBorder(),
            ),
          ),
          OutlinedButton(
            onPressed: () => _showRouteSheet(context, service),
            child: Icon(Icons.list_outlined),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              shape: StadiumBorder(),
            ),
          ),
        ]);
  }
}
