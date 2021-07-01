import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

class NearBusStopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.nearBusStopsLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.nearData[index];
                return Card(
                  color: Colors.lightBlueAccent,
                  child: Container(
                    //margin: const EdgeInsets.all(5),
                    //color: Colors.lightBlueAccent,
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.busStopCode),
                        Text(item.description),
                        Text(item.roadName),
                        Text('${item.distanceDisplay}km')
                      ],
                    ),
                  ),
                );
              },
              childCount: state.nearData.length,
            ),
          );
        }
      },
    );
  }
}
