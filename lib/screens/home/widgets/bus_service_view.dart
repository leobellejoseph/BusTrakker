import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/bus_route_screen.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';

class BusServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busServiceLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
              itemCount: state.serviceData.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final item = state.serviceData[index];
                final BusOperator operator = item.busOperator;
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      context
                          .read<BusRouteCubit>()
                          .fetchRoute(service: item.serviceNo);
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        elevation: 2,
                        context: context,
                        builder: (context) {
                          return BusRouteScreen(
                              service: item.serviceNo, code: '');
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
                          Expanded(
                            flex: 1,
                            child: Text(
                              operator.name,
                              style: TextStyle(
                                  color: operator.textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Divider(color: Colors.grey, height: 0),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Text(
                                item.serviceNo,
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
                  ),
                );
              });
        }
      },
    );
  }
}
