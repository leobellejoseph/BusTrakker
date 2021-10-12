import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopWidget extends StatefulWidget {
  final String code;
  BusStopWidget({required this.code});
  @override
  _BusStopWidgetState createState() => _BusStopWidgetState();
}

class _BusStopWidgetState extends State<BusStopWidget>
    with WidgetsBindingObserver {
  final FlipCardController controller = FlipCardController();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusRouteCubit, BusRouteState>(
      builder: (context, state) {
        if (state.status == BusRouteStatus.initial ||
            state.status == BusRouteStatus.loading_all ||
            state.status == BusRouteStatus.loading) {
          return const CenteredSpinner();
        } else if (state.status == BusRouteStatus.no_data) {
          return NoDataWidget.noData();
        } else {
          return FlipCard(
            controller: controller,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            front: BusServiceList(
                code: widget.code,
                onFlip: (value) {
                  if (value.isNotEmpty && widget.code.isNotEmpty) {
                    final arrival = context.read<BusArrivalCubit>();
                    arrival.getBusArrival(widget.code, value, false);
                    controller.state?.toggleCard();
                  }
                }),
            back: BusArrivalList(
              onFlip: () => controller.state?.toggleCard(),
            ),
          );
        }
      },
    );
  }
}
