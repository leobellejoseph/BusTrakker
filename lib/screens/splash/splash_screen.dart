import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  static const id = 'splash';
  static Route route() => MaterialPageRoute(
        settings: RouteSettings(name: SplashScreen.id),
        builder: (context) => SplashScreen(key: ValueKey('splash')),
      );
  final loadingTextStyle = GoogleFonts.permanentMarker(
      fontSize: 20, fontWeight: FontWeight.w300, color: Colors.green.shade500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BusDataBloc, BusDataState>(
        listener: (bloc, state) async {
          if (state.status == BusDataStatus.allLoaded) {
            final bool isLocationEnabled =
                await LocationRequest.isLocationEnabled();
            if (isLocationEnabled) {
              StorageHelper.write('location', '{true}');
              final permission = await LocationRequest.requestPermission();
              final hasPermission =
                  (permission == LocationPermission.whileInUse ||
                      permission == LocationPermission.always);
              if (hasPermission) {
                // load near bus stops
                context.read<NearBusCubit>().getNearMeBusStops();
              }
            }

            // load bus routes in the background
            context.read<BusRouteCubit>().fetchAllRoutes();
            // load favorites
            context.read<FavoritesCubit>().fetch();
            // navigate to home screen

            Future.delayed(
              const Duration(seconds: 1),
              () {
                if (isLocationEnabled) {
                  Navigator.popAndPushNamed(context, HomeScreen.id);
                } else {
                  Navigator.popAndPushNamed(context, LocationEnableScreen.id);
                }
              },
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.blueGrey.withOpacity(0.1),
                Colors.blue.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Image(
                    image: AssetImage('images/sglovebus.png'),
                    fit: BoxFit.cover),
                Expanded(
                  child: Center(
                    child: BlocBuilder<BusDataBloc, BusDataState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case BusDataStatus.busServiceLoading:
                            return Text('Loading Bus Services',
                                style: loadingTextStyle.copyWith(
                                    color: Colors.deepPurple));
                          case BusDataStatus.busStopsLoading:
                            return Text('Loading Bus Stops',
                                style: loadingTextStyle.copyWith(
                                    color: Colors.red));
                          case BusDataStatus.allLoaded:
                            return Text('Loading Complete...',
                                style: loadingTextStyle);
                          default:
                            return Text('Loading...',
                                style: loadingTextStyle.copyWith(
                                    color: Colors.yellow.shade600));
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SpinKitPouringHourGlassRefined(
                      color: Colors.deepPurple, size: 100),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Hero(
                    tag:'bus',
                    child: Image(
                        image: AssetImage('images/background1.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
