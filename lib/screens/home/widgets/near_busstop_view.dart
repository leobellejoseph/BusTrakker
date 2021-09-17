import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/widgets/centered_text.dart';
import 'package:my_bus/widgets/widgets.dart';

class NearBusStopsView extends StatefulWidget {
  NearBusStopsView({Key? key}) : super(key: key);
  @override
  _NearBusStopsViewState createState() => _NearBusStopsViewState();
}

class _NearBusStopsViewState extends State<NearBusStopsView> {
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
    return BlocBuilder<NearBusCubit, NearBusState>(
      builder: (context, state) {
        if (state.status == NearBusStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == NearBusStatus.no_data) {
          return NoDataWidget(
              title: 'No Data',
              subTitle: 'Unable to retrieve data.',
              caption: 'Refresh',
              onTap: () => context.read<NearBusCubit>().getNearMeBusStops(),
              showButton: true);
        } else if (state.status == NearBusStatus.no_location) {
          return NoDataWidget(
              title: 'Location not enabled',
              subTitle: 'Please enable location service.',
              caption: 'Open App Settings',
              onTap: () => LocationRequest.openAppSettings(),
              showButton: true);
        } else if (state.status == NearBusStatus.no_permission) {
          return NoDataWidget(
              title: 'Location Permission not set',
              subTitle: 'Please allow to retrieve location.',
              caption: 'Open App Settings',
              onTap: () => LocationRequest.openAppSettings(),
              showButton: true);
        } else {
          if (state.data.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                final BusDataBloc bloc = context.read<BusDataBloc>();
                final NearBusCubit cubit = context.read<NearBusCubit>();
                if (state.data.isEmpty) {
                  bloc.add(BusDataDownload());
                  cubit.getNearMeBusStops();
                } else {
                  cubit.getNearMeBusStops();
                }
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final item = state.data[index];
                  final heightFactor = 1;
                  final itemPositionOffset = index * kItemSize * heightFactor;
                  final difference =
                      scrollController.offset - itemPositionOffset;
                  final percent =
                      1.5 - (difference / (kItemSize * heightFactor));
                  double opacity = percent > 1.0 ? 1.0 : 0.0;
                  double scale = percent;
                  if (percent > 1.0) scale = 1.0;
                  return Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, 1),
                        child: BusStopTile(item: item, showDistance: true),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return CenteredTextButton(
                title: 'No Data. Tap to refresh.',
                subTitle: '',
                onTap: () {
                  context.read<NearBusCubit>().getNearMeBusStops();
                });
          }
        }
      },
    );
  }
}
