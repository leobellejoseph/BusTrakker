import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/base_bus_repository.dart';

class BusRepository extends BaseBusRepository {
  final List<BusStop> _stops = [];
  final List<BusService> _services = [];
  final List<BusRoute> _routes = [];
  final List<Favorite> _favorites = [];

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

  @override
  Future<List<Favorite>> fetchFavorites() async {
    final List<Favorite> data = [
      Favorite(serviceNo: '106', busStopCode: '11401'),
      Favorite(serviceNo: '106', busStopCode: '11409'),
      Favorite(serviceNo: '185', busStopCode: '11381'),
      Favorite(serviceNo: '48', busStopCode: '11381'),
      Favorite(serviceNo: '970', busStopCode: '11401'),
      Favorite(serviceNo: '95', busStopCode: '11401'),
      Favorite(serviceNo: '61', busStopCode: '11409'),
      Favorite(serviceNo: '74', busStopCode: '11389'),
      Favorite(serviceNo: '111', busStopCode: '11189'),
    ];
    _favorites.addAll(data);
    return _favorites;
  }

  @override
  Favorite getFavorite({required String service, required String code}) =>
      _favorites
          .where((element) =>
              element.serviceNo == service && element.busStopCode == code)
          .first;

  @override
  bool isFavorite({required String service, required String code}) => _favorites
      .where((e) => e.busStopCode == code && e.serviceNo == service)
      .isNotEmpty;

  @override
  List<Favorite> addFavorite({required Favorite favorite}) {
    _favorites.add(favorite);
    return _favorites;
  }

  @override
  List<Favorite> removeFavorite({required Favorite favorite}) {
    print(_favorites.length);
    _favorites.remove(favorite);
    print(_favorites.length);
    return _favorites;
  }
}
