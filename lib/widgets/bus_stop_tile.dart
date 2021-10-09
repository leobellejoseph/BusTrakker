import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopTile extends StatelessWidget {
  final BusStop item;
  final bool showDistance;

  BusStopTile({Key? key, required this.item, required this.showDistance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusArrivalCubit(),
      child: Card(
        child: SizedBox(
          height: kBusStopTileSize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              BusStopLabel(item: item),
              const Divider(
                color: Colors.white,
                height: 0.4,
              ),
              BusStopHeader(item: item, showDistance: showDistance),
              const Divider(
                color: Colors.white,
                height: 0.4,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1b7b90).withOpacity(0.6),
                        Color(0xFF1b7b90).withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: BusStopWidget(code: item.busStopCode),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
