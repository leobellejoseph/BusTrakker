import 'package:geolocator/geolocator.dart';

class BusStop {
  late final String busStopCode;
  late final String roadName;
  late final String description;
  late final double latitude;
  late final double longitude;
  final List<String> keywords = [];
  String distanceDisplay = '';
  int distanceInt = 0;
  BusStop(
      {required this.busStopCode,
      required this.roadName,
      required this.description,
      required this.latitude,
      required this.longitude});

  factory BusStop.empty() => BusStop(
      busStopCode: '',
      roadName: '',
      description: '',
      latitude: 0,
      longitude: 0);

  BusStop.fromJson(Map<String, dynamic> data) {
    busStopCode = data['BusStopCode'];
    roadName = data['RoadName'];
    description = data['Description'];
    latitude = data['Latitude'];
    longitude = data['Longitude'];
  }

  Map<String, dynamic> toJson() => {
        'BusStopCode': busStopCode,
        'RoadName': roadName,
        'Description': description,
        'Latitude': latitude,
        'Longitude': longitude
      };

  void setDistance(Position position) {
    double distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, latitude, longitude);
    distanceDisplay = (distance / 1000).toStringAsFixed(2);
    distanceInt = distance.toInt();
  }

  void setKeywords(String keyword) => keywords.add(keyword);

  String get getKewords => keywords.join(',');
}
