import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';

class BusRouteScreen extends StatelessWidget {
  final String service;
  final String code;
  BusRouteScreen({required this.service, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: Colors.greenAccent.shade200,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                      padding:
                          const EdgeInsets.only(left: 6, top: 2, bottom: 2),
                      child: Text(service,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30)),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                ],
              )), //Service Label
          const Divider(height: 0, color: Colors.white),
          Container(
            height: 40,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text('Road Name',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      )),
                  //Container(height: 40, color: Colors.white54, width: 1),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Text('Bus Stop Code',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  //Container(height: 40, color: Colors.white, width: 1),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BusRouteCubit, BusRouteState>(
              builder: (context, state) {
                if (state.status == BusRouteStatus.loaded) {
                  return ListView.separated(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final item = state.data[index];
                      final prev = index - 1;
                      final prevIndex = prev < 0 ? index : prev;
                      final prevData = state.data[prevIndex];
                      final BusStop info = context
                          .read<BusRouteCubit>()
                          .fetchBusStopInfo(item.busStopCode);
                      final BusStop prevInfo = context
                          .read<BusRouteCubit>()
                          .fetchBusStopInfo(prevData.busStopCode);
                      final showRoadName =
                          (prevInfo.roadName != info.roadName ||
                              prevIndex == 0);
                      final currentBusStop = code == info.busStopCode;
                      return Container(
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.lightBlueAccent.withOpacity(0.8),
                                Colors.lightBlueAccent.withOpacity(0.4),
                              ]),
                        ),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Visibility(
                                visible: showRoadName,
                                child: Container(
                                  height: double.infinity,
                                  color: currentBusStop
                                      ? Colors.red
                                      : Colors.transparent,
                                  child: Text(
                                    info.roadName,
                                    style: TextStyle(
                                      color: currentBusStop
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: double.infinity,
                                color: currentBusStop
                                    ? Colors.red
                                    : Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 35,
                                        color: Colors.red,
                                        width: 2),
                                    const SizedBox(width: 2),
                                    Text(
                                      item.busStopCode,
                                      style: TextStyle(
                                        color: currentBusStop
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  height: double.infinity,
                                  color: currentBusStop
                                      ? Colors.red
                                      : Colors.transparent,
                                  child: Text(
                                    info.description,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: currentBusStop
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0, color: Colors.black54),
                  );
                } else if (state.status == BusRouteStatus.error) {
                  return Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
