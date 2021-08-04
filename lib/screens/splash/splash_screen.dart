import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';
import 'package:my_bus/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const id = 'splash';

  static Route route() => MaterialPageRoute(
        settings: RouteSettings(name: SplashScreen.id),
        builder: (context) => SplashScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<BusDataBloc, BusDataState>(
        listener: (bloc, state) async {
          if (state.status == BusDataStatus.allLoaded) {
            final bool location = StorageHelper.exists('location');

            if (location == false) {
              final bool isLocationEnabled =
                  await LocationRequest.isLocationEnabled();
              if (isLocationEnabled) {
                final permission = await LocationRequest.requestPermission();
                final hasPermission =
                    (permission == LocationPermission.whileInUse ||
                        permission == LocationPermission.always);
                if (hasPermission) {
                  // load near bus stops
                  context.read<NearBusCubit>().getNearMeBusStops();
                }
              }
              // load favorites
              context.read<FavoritesCubit>().fetch();
              // load bus routes in the background
              context.read<BusRouteCubit>().fetchAllRoutes();
              // navigate to home screen

              Future.delayed(const Duration(seconds: 1), () {
                if (isLocationEnabled) {
                  Navigator.pushNamed(context, HomeScreen.id);
                } else {
                  Navigator.pushNamed(context, LocationEnableScreen.id);
                }
              });
            } else {
              Navigator.pushNamed(context, HomeScreen.id);
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage('images/splash.png'), fit: BoxFit.cover),
            const SizedBox(height: 10),
            Center(
              child: BlocBuilder<BusDataBloc, BusDataState>(
                builder: (context, state) {
                  switch (state.status) {
                    case BusDataStatus.busServiceLoading:
                      return const Text('Loading Bus Services',
                          style: TextStyle(color: Colors.green));
                    case BusDataStatus.busStopsLoading:
                      return const Text('Loading Bus Stops',
                          style: TextStyle(color: Colors.black54));
                    case BusDataStatus.allLoaded:
                      return const Text('Loading Complete...');
                    default:
                      return const Text('Loading...');
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
