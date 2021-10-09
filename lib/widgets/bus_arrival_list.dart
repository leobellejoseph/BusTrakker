import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/screens/screens.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusArrivalList extends StatelessWidget {
  final Function onFlip;
  BusArrivalList({Key? key, required this.onFlip});

  // void _toggleFavorite(BuildContext context, String code, String service) {
  //   final repo = context.read<BusRepository>();
  //   final fave = context.read<FavoritesCubit>();
  //   final isFavorite = repo.isFavorite(service: service, code: code);
  //   if (isFavorite) {
  //     fave.removeFavorite(code, service);
  //   } else {
  //     fave.addFavorite(code: code, service: service);
  //   }
  // }

  void _showRouteSheet(BuildContext context, String service, String code) {
    BusRouteCubit route = context.read<BusRouteCubit>();
    route.fetchRoute(service: service);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 2,
      context: context,
      builder: (context) {
        route.fetchRoute(service: service, code: code);
        return BusRouteScreen(service: service, code: code);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusArrivalCubit, BusArrivalState>(
      builder: (context, state) {
        if (state.status == BusArrivalStatus.initial) {
          return Container();
        } else if (state.status == BusArrivalStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == BusArrivalStatus.no_internet) {
          return CenteredText.noInternet();
          // return CenteredText(
          //     text: 'No Connection. Please check network connection.');
        } else if (state.status == BusArrivalStatus.loaded) {
          final service = state.data.serviceNo;
          final code = state.data.busStopCode;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: BusArrivalToggleButton(
                        onFlip: () => onFlip(),
                        service: state.data.serviceNo,
                        onShowRoute: () =>
                            _showRouteSheet(context, service, code),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: () {
                          final arrival = context.read<BusArrivalCubit>();
                          arrival.getBusArrival(code, service, true);
                        },
                        child:
                            NextBusWidget(bus: state.data.firstBus, index: 1),
                      ),
                    ),
                    Expanded(
                      child: NextBusWidget(bus: state.data.secondBus, index: 2),
                    ),
                  ],
                ),
                // Transform.translate(
                //   offset: const Offset(310, -5),
                //   child: FavoriteButton(
                //     key: const ValueKey('FavoritesButton'),
                //     service: service,
                //     code: code,
                //     onPress: () => _toggleFavorite(context, code, service),
                //   ),
                // ),
              ],
            ),
          );
        } else {
          return NoDataWidget.noInternet();
        }
      },
    );
  }
}
