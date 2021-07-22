import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/base_bus_repository.dart';

class BusRepository extends BaseBusRepository {
  final List<BusStop> _stops = [];
  final List<BusService> _services = [];
  final List<BusRoute> _routes = [];
  final List<Favorite> _favorites = [];
  SelectedRoute selected = SelectedRoute(code: '', service: '');
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
    final List<Favorite> data = [];
    dynamic fromJson = HydratedBloc.storage.read(StorageKey.Favorites);
    if (fromJson != null) {
      List<Favorite> temp = (jsonDecode(fromJson) as List)
          .map((e) => Favorite.fromJson(e))
          .toList();
      _favorites.addAll(temp);
    }
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
    if (!_favorites.contains(favorite)) {
      _favorites.add(favorite);
      // List<Favorite> temp = [favorite];
      // temp.addAll(_favorites);
      // _favorites.clear();
      // _favorites.addAll(temp);

      dynamic data = _favorites.map((e) => e.toJson()).toList();
      HydratedBloc.storage.write(StorageKey.Favorites, jsonEncode(data));
    }
    return _favorites;
  }

  @override
  List<Favorite> removeFavorite({required Favorite favorite}) {
    if (_favorites.contains(favorite)) _favorites.remove(favorite);
    return _favorites;
  }

  @override
  SelectedRoute getSelectedRoute() => selected;

  @override
  void setSelectedRoute({required String code, required String service}) {
    selected = SelectedRoute(code: code, service: service);
  }
}
