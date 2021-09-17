import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';
import 'package:my_bus/screens/screens.dart';
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

  void _showRouteSheet(BuildContext context, String service) {
    BusRouteCubit route = context.read<BusRouteCubit>();
    route.fetchRoute(service: service);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 2,
      context: context,
      builder: (context) {
        route.fetchRoute(service: service, code: widget.code);
        return BusRouteScreen(service: service, code: widget.code);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusArrivalCubit(),
      child: BusServiceList(
          code: widget.code,
          onFlip: (service) {
            if (service.isNotEmpty && widget.code.isNotEmpty) {
              final arrival = context.read<BusArrivalCubit>();
              arrival.getBusArrival(widget.code, service, false);
              final messenger = ScaffoldMessenger.of(context);
              messenger.hideCurrentMaterialBanner();
              final banner = MaterialBanner(
                  content: SafeArea(
                    child: SizedBox(
                      height: 200,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlueAccent.withOpacity(0.3),
                            Colors.lightBlueAccent.withOpacity(0.5),
                          ]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(service,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700)),
                            const Divider(height: 0.4, color: Colors.black54),
                            //BusArrivalList(service: service, code: widget.code),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .hideCurrentMaterialBanner(),
                      child: Icon(Icons.arrow_circle_up),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: StadiumBorder(),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Icon(CupertinoIcons.refresh_circled),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.green,
                        shape: StadiumBorder(),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Icon(Icons.favorite),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.yellow,
                        shape: StadiumBorder(),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => _showRouteSheet(context, service),
                      child: Icon(Icons.list_outlined),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ]);
              messenger.showMaterialBanner(banner);
            }
          }),
    );
    // return BlocProvider(
    //   create: (context) => BusArrivalCubit(),
    //   child: FlipCard(
    //     controller: controller,
    //     flipOnTouch: false,
    //     direction: FlipDirection.VERTICAL,
    //     front: BusServiceList(
    //         code: widget.code,
    //         onFlip: (service) {
    //           if (service.isNotEmpty && widget.code.isNotEmpty) {
    //             print('SERVICE:$service CODE:${widget.code}');
    //             final arrival = context.read<BusArrivalCubit>();
    //             arrival.getBusArrival(widget.code, service, false);
    //             controller.state?.toggleCard();
    //           }
    //         }),
    //     back: BusArrivalList(onFlip: () => controller.state?.toggleCard()),
    //   ),
    // );
    // return BlocBuilder<BusArrivalsCubit, BusArrivalsState>(
    //   builder: (context, state) {
    //     if (state.status == Status.loading) {
    //       return LinearProgressIndicator();
    //     } else if (state.status == Status.no_internet) {
    //       return NoDataWidget(
    //           title: 'No Internet',
    //           subTitle: 'Please check connection settings.',
    //           caption: '',
    //           onTap: () {},
    //           showButton: false);
    //     } else if (state.status == Status.no_service) {
    //       return NoDataWidget(
    //           title: 'No Service',
    //           subTitle: '',
    //           caption: '',
    //           onTap: () {},
    //           showButton: false);
    //     } else {
    //       return FlipCard(
    //         controller: controller,
    //         flipOnTouch: false,
    //         direction: FlipDirection.VERTICAL,
    //         front: BusServiceList(
    //             code: widget.code,
    //             state: state,
    //             onFlip: (service) {
    //               if (service.isNotEmpty && widget.code.isNotEmpty) {
    //                 final arrival = context.read<BusArrivalCubit>();
    //                 arrival.getBusArrival(widget.code, service, false);
    //                 controller.state?.toggleCard();
    //               }
    //             }),
    //         back: BusArrivalList(onFlip: () => controller.state?.toggleCard()),
    //       );
    //     }
    //   },
    // );
  }
}
