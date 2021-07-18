import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';

class BusRouteScreen extends StatelessWidget {
  final String service;

  BusRouteScreen({required this.service});

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
                      final previous = state.data[index - index == 0 ? 0 : 1];
                      final BusStop info = context
                          .read<BusRouteCubit>()
                          .fetchBusStopInfo(item.busStopCode);
                      final BusStop prevInfo = context
                          .read<BusRouteCubit>()
                          .fetchBusStopInfo(previous.busStopCode);
                      return Container(
                        height: 35,
                        color: Colors.lightBlueAccent.shade100,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: prevInfo.roadName == info.roadName &&
                                      index > 0
                                  ? Container()
                                  : Text(info.roadName),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 35, color: Colors.red, width: 2),
                                  Text(item.busStopCode,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                            Expanded(flex: 4, child: Text(info.description)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 0, color: Colors.grey),
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
