import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/screens/home/cubit/near_stops_cubit.dart';

class NearBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NearStopsCubit>(context).showNearBusStops();
    return BlocBuilder<NearStopsCubit, NearStopsState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = state.data[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  color: Colors.lightBlueAccent,
                  height: 150,
                  width: double.infinity,
                  child: Center(child: Text(item.busStopCode)),
                ),
              );
            },
            childCount: state.data.length,
          ),
        );
      },
    );
    ;
  }
}
