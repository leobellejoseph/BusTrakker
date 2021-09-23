import 'package:geolocator/geolocator.dart';

class BusStop {
  final String busStopCode;
  final String roadName;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> keywords = [];
  String distanceDisplay = '';
  int distanceInt = 0;

  static Map<String, BusStop> _cache = {};

  BusStop._instance(
      {required this.busStopCode,
      required this.roadName,
      required this.description,
      required this.latitude,
      required this.longitude});

  factory BusStop(
          {required String busStopCode,
          required String roadName,
          required String description,
          required double latitude,
          required double longitude}) =>
      _cache[busStopCode] ??= BusStop._instance(
          busStopCode: busStopCode,
          roadName: roadName,
          description: description,
          latitude: latitude,
          longitude: longitude);

  factory BusStop.empty() => BusStop._instance(
      busStopCode: '',
      roadName: '',
      description: '',
      latitude: 0,
      longitude: 0);

  factory BusStop.fromJson(Map<String, dynamic> data) {
    final code = data['BusStopCode'];
    final roadName = data['RoadName'];
    final description = data['Description'];
    final latitude = data['Latitude'];
    final longitude = data['Longitude'];
    return _cache[code] ??= BusStop._instance(
      busStopCode: code,
      roadName: roadName,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
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
