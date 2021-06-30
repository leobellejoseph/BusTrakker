import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

class BusStopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busStopsLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.stopsData[index];
                return Card(
                  color: Colors.lightBlueAccent,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.busStopCode),
                        Text(item.description),
                        Text(item.roadName),
                      ],
                    ),
                  ),
                );
              },
              childCount: state.stopsData.length,
            ),
          );
        }
      },
    );
    // return SliverGrid(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 2,
    //     crossAxisSpacing: 2,
    //   ),
    //   delegate: SliverChildBuilderDelegate(
    //     (context, index) {
    //       return Card(
    //         color: Colors.grey,
    //       );
    //     },
    //     childCount: 4,
    //   ),
    // );
  }
}
