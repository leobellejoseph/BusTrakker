import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopsView extends StatefulWidget {
  BusStopsView({Key? key}) : super(key: key);
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
          return NoDataWidget(
              title: 'No Internet',
              subTitle: 'Please check connection settings.',
              caption: 'Refresh',
              onTap: () {
                context.read<BusDataBloc>()..add(BusDataDownload());
              },
              showButton: false);
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                final index =
                    (scrollController.position.pixels.toInt() / 100).floor();
                print(index);
              } else {}
              return true;
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.stopsData.length,
              itemBuilder: (context, index) {
                final item = state.stopsData[index];
                return BusStopTile(item: item, showDistance: false);
              },
            ),
          );
        }
      },
    );
  }
}
