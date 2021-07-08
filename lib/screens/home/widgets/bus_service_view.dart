import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/models/bus_service.dart';

class BusServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busServiceLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.serviceData[index];
                final BusOperator operator = item.busOperator;
                return Card(
                  //color: Colors.lightBlueAccent,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            operator.color.withOpacity(0.8),
                            operator.color.withOpacity(0.3),
                            operator.color.withOpacity(0.2),
                          ]),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          operator.name,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        const Divider(),
                        Expanded(
                          child: Center(
                            child: Text(
                              item.serviceNo,
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: state.serviceData.length,
            ),
          );
        }
      },
    );
  }
}
