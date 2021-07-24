import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopsView extends StatefulWidget {
  @override
  _BusStopsViewState createState() => _BusStopsViewState();
}

class _BusStopsViewState extends State<BusStopsView> {
  final scrollController = ScrollController();
  void onScroll() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
  }

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
            controller: scrollController,
            itemCount: state.stopsData.length,
            itemBuilder: (context, index) {
              final item = state.stopsData[index];
              final heightFactor = 1;
              final itemPositionOffset = index * kItemSize * heightFactor;
              final difference = scrollController.offset - itemPositionOffset;
              final percent = 1.7 - (difference / (kItemSize * heightFactor));
              double opacity = percent;
              double scale = percent;
              if (opacity > 1.0) opacity = 1.0;
              if (opacity < 0.0) opacity = 0.0;
              if (percent > 1.0) scale = 1.0;
              return BlocProvider<BusArrivalsCubit>(
                create: (context) => BusArrivalsCubit(),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: opacity,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(scale, 1),
                      child: BusStopTile(
                          item: item, showDistance: false, height: kItemSize),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
