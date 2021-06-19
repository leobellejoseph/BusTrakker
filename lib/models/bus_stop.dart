import 'package:geolocator/geolocator.dart';

class BusStop {
  late String busStopCode;
  late String roadName;
  late String description;
  late double latitude;
  late double longitude;
  String distanceDisplay = '';
  int distanceInt = 0;

  BusStop.fromJson(Map<String, dynamic> data) {
    busStopCode = data['BusStopCode'];
    roadName = data['RoadName'];
    description = data['Description'];
    latitude = data['Latitude'];
    longitude = data['Longitude'];
  }

  void setDistance(Position userPosition) {
    double distance = Geolocator.distanceBetween(
        userPosition.latitude, userPosition.longitude, latitude, longitude);
    distanceDisplay = (distance / 1000).toStringAsFixed(2);
    distanceInt = distance.toInt();
  }
}
