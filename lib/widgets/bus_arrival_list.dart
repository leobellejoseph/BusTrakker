import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/screens/screens.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusArrivalList extends StatelessWidget {
  final Function onFlip;

  BusArrivalList({required this.onFlip});

  void _toggleFavorite(BuildContext context, String code, String service) {
    final repo = context.read<BusRepository>();
    final fave = context.read<FavoritesCubit>();
    final stop = repo.getBusStop(code);
    final isFavorite = repo.isFavorite(service: service, code: code);
    if (isFavorite) {
      fave.removeFavorite(code, service);
    } else {
      fave.addFavorite(code: code, service: service);
    }
  }

  void _showRouteSheet(BuildContext context) {
    SelectedRoute selected = context.read<BusRepository>().selected;
    BusRouteCubit route = context.read<BusRouteCubit>();
    route.fetchRoute(service: selected.service);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 2,
      context: context,
      builder: (context) {
        route.fetchRoute(service: selected.service, code: selected.code);
        return BusRouteScreen(service: selected.service, code: selected.code);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusArrivalCubit, BusArrivalState>(
      builder: (context, state) {
        if (state.status == BusArrivalStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == BusArrivalStatus.no_internet) {
          return CenteredText(
              text: 'No Connection. Please check network connection.');
        } else {
          final service = state.data.serviceNo;
          final code = state.data.busStopCode;
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.lightBlue.withOpacity(0.6),
                                Colors.lightBlue.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: RawMaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  highlightColor: Colors.lightBlue,
                                  onPressed: () => _showRouteSheet(context),
                                  child: Center(
                                    child: Text(
                                      state.data.serviceNo,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.white, height: 0),
                              Expanded(
                                child: RawMaterialButton(
                                  highlightColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => onFlip(),
                                  child: Icon(
                                    Icons.keyboard_arrow_up_sharp,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                Transform.translate(
                  offset: const Offset(310, -5),
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, fstate) {
                      if (fstate.status == FavoriteStatus.loading) {
                        //return Container();
                        return CircularProgress(key: ValueKey('progress'));
                      } else {
                        final repo = context.read<BusRepository>();

                        final isFavorite =
                            repo.isFavorite(service: service, code: code);

                        return IconButton(
                          onPressed: () =>
                              _toggleFavorite(context, code, service),
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: Colors.yellow.shade600,
                            size: 40,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
