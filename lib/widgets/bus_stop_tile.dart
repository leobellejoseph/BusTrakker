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
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1b7b90),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        item.description,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        item.busStopCode,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
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
              height: 20,
              color: Color(0xFF79ab8c),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      showDistance == true && item.distanceDisplay.isNotEmpty
                          ? TextSpan(
                              text: '${item.distanceDisplay}km @ ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          : TextSpan(),
                      TextSpan(
                        text: item.roadName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // child: Text(
                //   item.roadName,
                //   style: TextStyle(
                //       color: Color(0xFF1b7b90),
                //       fontWeight: FontWeight.w600,
                //       fontSize: 14),
                // ),
              ),
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
