import 'package:my_bus/models/bus_arrival.dart';

class Favorite {
  final String busStopCode;
  final String serviceNo;
  final BusArrival arrival;
  Favorite(
      {required this.busStopCode,
      required this.serviceNo,
      required this.arrival});
}
