import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
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
      height: 210,
      width: double.infinity,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BusArrivalsCubit>(
              create: (context) => BusArrivalsCubit()),
          BlocProvider<BusArrivalCubit>(create: (context) => BusArrivalCubit()),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xFF1b7b90),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.busStopCode,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: item.roadName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        showDistance == true && item.distanceDisplay.isNotEmpty
                            ? TextSpan(
                                text: ' @ ${item.distanceDisplay}km',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              )
                            : TextSpan(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
              height: 0.4,
            ),
            Container(
              height: 25,
              color: Color(0xFF79ab8c),
              child: Center(
                  child: Text(
                item.description,
                style: TextStyle(
                    color: Color(0xFF1b7b90),
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              )),
            ),
            const Divider(
              color: Colors.white,
              height: 0.5,
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
    );
  }
}
