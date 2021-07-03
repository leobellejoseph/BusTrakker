import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

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
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.serviceData[index];
                return Card(
                  color: Colors.lightBlueAccent,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.serviceNo),
                        Text(item.operator),
                      ],
                    ),
                  ),
                );
              },
              childCount: state.serviceData.length,
            ),
          );
          // return SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       final item = state.serviceData[index];
          //       return Card(
          //         color: Colors.lightBlueAccent,
          //         child: Container(
          //           height: 150,
          //           width: double.infinity,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(item.serviceNo),
          //               Text(item.operator),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //     childCount: state.serviceData.length,
          //   ),
          // );
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
