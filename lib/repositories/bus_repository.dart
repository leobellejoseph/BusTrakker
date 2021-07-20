import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/base_bus_repository.dart';

class BusRepository extends BaseBusRepository {
  final List<BusStop> _stops = [];
  final List<BusService> _services = [];
  final List<BusRoute> _routes = [];
  @override
  List<BusStop> getNearStops(int distance) {
    return _stops;
  }

  @override
  BusService getBusService(String service) =>
      _services.where((element) => element.serviceNo == service).first;

  @override
  BusStop getBusStop(String code) =>
      _stops.where((element) => element.busStopCode == code).first;

  @override
  Future<List<BusService>> fetchBusServices() async {
    final data = await HTTPRequest.loadBusServices();
    _services.addAll(data);
    return _services;
  }

  @override
  Future<List<BusStop>> fetchBusStops() async {
    final data = await HTTPRequest.loadBusStops();
    _stops.addAll(data);
    return _stops;
  }

  @override
  List<BusRoute> getBusRoute({String service = '', String code = ''}) =>
      _routes.where((element) => element.serviceNo == service).toList();

  @override
  List<BusService> getAllBusService() => _services;

  @override
  List<BusStop> getAllBusStops() => _stops;

  @override
  Future<List<BusRoute>> fetchBusRoutes() async {
    final data = await HTTPRequest.loadBusRoutes();
    _routes.addAll(data);
    return _routes;
  }
}
