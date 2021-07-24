import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busStopsLoading) {
          return SliverToBoxAdapter(child: CenteredSpinner());
        } else if (state.status == BusDataStatus.no_internet) {
          return CenteredText(text: 'No internet. Please check connection.');
        } else {
          return ListView.builder(
            itemCount: state.stopsData.length,
            itemBuilder: (context, index) {
              final item = state.stopsData[index];
              return BlocProvider<BusArrivalsCubit>(
                create: (context) => BusArrivalsCubit(),
                child: BusStopTile(item: item, showDistance: false),
              );
            },
          );
        }
      },
    );
  }
}
