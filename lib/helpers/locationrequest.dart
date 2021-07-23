import 'package:geolocator/geolocator.dart';

class LocationRequest {
  static Position defaultPosition() => Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        speedAccuracy: 0,
        heading: 0,
        speed: 0,
      );

  static Future<Position> getLocationPosition() async {
    Position _position = LocationRequest.defaultPosition();

    // check if location permission is enabled
    // LocationPermission permission =
    //     await LocationRequest.checkLocationPermission();

    // check if permissions are valid
    // if (permission != LocationPermission.always ||
    //     permission != LocationPermission.whileInUse) {
    //   permission = await LocationRequest.requestPermission();
    // }

    // if (permission == LocationPermission.always ||
    //     permission == LocationPermission.whileInUse) {
    // get current location
    _position = await LocationRequest.determinePosition();
    //}
    print(_position.longitude);
    return _position;
  }

  static Future<bool> isLocationEnabled() async {
    final bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    return isLocationServiceEnabled;
  }

  static Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  static Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  static Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  static Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission;
  }

  static Future<Position> determinePosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    //return Future.error('Location services are disabled.');
    //   await Geolocator.openLocationSettings();
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    // return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
    //   await Geolocator.openLocationSettings();
    // }

    // if (permission == LocationPermission.denied) {
    // Permissions are denied, next time you could try
    // requesting permissions again (this is also where
    // Android's shouldShowRequestPermissionRationale
    // returned true. According to Android guidelines
    // your App should show an explanatory UI now.
    //   return Future.error('Location permissions are denied');
    // }
    // }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 2));
  }
}
