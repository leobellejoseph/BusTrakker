import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
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
          return NoDataWidget.noDataRefresh(
            onClick: () => context.read<NearBusCubit>().getNearMeBusStops(),
          );
        } else if (state.status == NearBusStatus.no_location) {
          return NoDataWidget.noLocation(
            onClick: () => LocationRequest.openAppSettings(),
          );
        } else if (state.status == NearBusStatus.no_permission) {
          return NoDataWidget.noPermission(
            onClick: () => LocationRequest.openAppSettings(),
          );
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
                  return Align(
                    alignment: Alignment.center,
                    child: BusStopTile(item: item, showDistance: true),
                  );
                },
              ),
            );
          } else {
            return CenteredTextButton.refresh(
              onClick: () => context.read<NearBusCubit>().getNearMeBusStops(),
            );
          }
        }
      },
    );
  }
}
