import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const id = 'splash';
  static Route route() => MaterialPageRoute(
        settings: RouteSettings(name: SplashScreen.id),
        builder: (context) => SplashScreen(),
      );

  Future<Position> getLocationPosition() async {
    bool isValid = false;
    Position _position = LocationRequest.defaultPosition();
    // check if phone location setting is enabled
    bool isLocationEnabled = await LocationRequest.isLocationEnabled();

    // if not enabled, open location settings and let user enable.
    if (!isLocationEnabled) LocationRequest.openLocationSettings();

    // check if location permission is enabled
    LocationPermission permission =
        await LocationRequest.checkLocationPermission();

    // check if permissions are valid
    if (permission != LocationPermission.always ||
        permission != LocationPermission.whileInUse) {
      permission = await LocationRequest.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // get current location
      _position = await LocationRequest.determinePosition();
    }
    return _position;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<BusStopBloc, BusStopState>(
        listener: (context, state) async {
          if (state.status == BusStopStatus.loaded) {
            Position _position = await getLocationPosition();
            context.read<BusStopBloc>()
              ..add(
                NearBusStopsFetch(distance: 500, position: _position),
              );
            Navigator.pushNamed(context, HomeScreen.id);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Loading...'),
              const SizedBox(height: 10),
              CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
