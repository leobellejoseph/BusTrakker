import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/bus_arrival_cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopTile extends StatelessWidget {
  final BusStop item;
  final bool showDistance;
  BusStopTile({required this.item, required this.showDistance});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      height: 200,
      width: double.infinity,
      child: BlocProvider<BusArrivalCubit>(
        create: (context) => BusArrivalCubit(),
        child: BusStopWidget(
          code: item.busStopCode,
          roadName: item.roadName,
          description: item.description,
          distance: showDistance ? '${item.distanceDisplay}km' : '',
          showServices: false,
        ),
      ),
    );
  }
}
