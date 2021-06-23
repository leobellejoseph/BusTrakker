import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/screens/home/cubit/near_stops_cubit.dart';

class NearBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearStopsCubit, NearStopsState>(
      builder: (context, state) {
        switch (state.status) {
          case NearStopsStatus.loading:
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = state.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: state.data.length,
              ),
            );
        }
      },
    );
  }
}
