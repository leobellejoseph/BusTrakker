import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/screens.dart';

class ServiceWidget extends StatelessWidget {
  final BusService service;
  const ServiceWidget({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final operator = service.busOperator;
    return RawMaterialButton(
      onPressed: () {
        context.read<BusRouteCubit>().fetchRoute(service: service.serviceNo);
        showModalBottomSheet(
          backgroundColor: Colors.white,
          elevation: 2,
          context: context,
          builder: (context) {
            return BusRouteScreen(service: service.serviceNo, code: '');
          },
        );
      },
      highlightColor: operator.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                operator.color.withOpacity(0.9),
                operator.color.withOpacity(0.3),
                operator.color.withOpacity(0.2),
              ]),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              operator.name,
              style: TextStyle(
                  color: operator.textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            const Divider(color: Colors.black54, height: 0),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  service.serviceNo,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
