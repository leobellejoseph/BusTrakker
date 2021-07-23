import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/screens/screens.dart';

class LocationEnableScreen extends StatefulWidget {
  static const id = 'location';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: LocationEnableScreen.id),
        builder: (context) => LocationEnableScreen(),
      );

  @override
  _LocationEnableScreenState createState() => _LocationEnableScreenState();
}

class _LocationEnableScreenState extends State<LocationEnableScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final bool isLocationEnabled = await LocationRequest.isLocationEnabled();
      if (isLocationEnabled == true) {
        BlocProvider.of<NearBusCubit>(context).getNearMeBusStops('');
        Navigator.pushNamed(context, HomeScreen.id);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('images/MyBusLogo.jpg'), fit: BoxFit.fill),
              const Divider(height: 1),
              //Icon(Icons.location_off, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 20),
              Text(
                  'This app uses location with permission to see which Bus Stops are near to you. Do you want to enable locations?'),
              TextButton(
                onPressed: () {
                  HydratedBloc.storage.write('location', '{true}');
                  Geolocator.openLocationSettings();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings),
                    Text(
                      'Open Settings',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  HydratedBloc.storage.write('location', '{true}');
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
