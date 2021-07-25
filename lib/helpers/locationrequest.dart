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
    _position = await LocationRequest.determinePosition();
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
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 8));
  }
}
