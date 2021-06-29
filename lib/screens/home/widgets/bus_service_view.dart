import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

class BusServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<BusDataBloc>(context).state;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = state.serviceData[index];
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
                  Text(item.serviceNo),
                  Text(item.operator),
                ],
              ),
            ),
          );
        },
        childCount: state.stopsData.length,
      ),
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
