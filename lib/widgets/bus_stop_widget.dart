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
    BlocProvider.of<BusRouteCubit>(context).fetchServices(code: widget.code);
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
    if (state == AppLifecycleState.resumed) {
      context.read<BusArrivalsCubit>().getBusServices(widget.code);
    }
    super.didChangeAppLifecycleState(state);
  }

  // void _showRouteSheet(BuildContext context, String service) {
  //   ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  //   BusRouteCubit route = context.read<BusRouteCubit>();
  //   route.fetchRoute(service: service);
  //   showModalBottomSheet(
  //     backgroundColor: Colors.white,
  //     elevation: 2,
  //     context: context,
  //     builder: (context) {
  //       route.fetchRoute(service: service, code: widget.code);
  //       return BusRouteScreen(service: service, code: widget.code);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusRouteCubit, BusRouteState>(
      builder: (context, state) {
        if (state.status == BusRouteStatus.loading) {
          return LinearProgressIndicator();
        } else if (state.status == BusRouteStatus.no_data) {
          return NoDataWidget(
              title: 'No Internet',
              subTitle: 'Please check connection settings.',
              caption: '',
              onTap: () {},
              showButton: false);
        } else {
          return FlipCard(
            controller: controller,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            front: BusServiceList(
                code: widget.code,
                onFlip: (service) {
                  if (service.isNotEmpty && widget.code.isNotEmpty) {
                    final arrival = context.read<BusArrivalCubit>();
                    arrival.getBusArrival(widget.code, service, false);
                    controller.state?.toggleCard();
                  }
                }),
            back: BusArrivalList(
              onFlip: () => controller.state?.toggleCard(),
              code: widget.code,
              service: '106',
            ),
          );
        }
      },
    );
  }
}
