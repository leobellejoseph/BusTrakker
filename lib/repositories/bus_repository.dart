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
    dynamic fromJson = HydratedBloc.storage.read(StorageKey.BusServices);
    _services.clear();
    if (fromJson == null) {
      final data = await HTTPRequest.loadBusServices();
      _services.addAll(data);
      final tmpData = _services.map((e) => e.toJson()).toList();
      HydratedBloc.storage.write(StorageKey.BusServices, jsonEncode(tmpData));
    } else {
      final data = jsonDecode(fromJson);
      final List<BusService> list =
          (data as List).map((e) => BusService.fromJson(e)).toList();
      _services.addAll(list);
    }
    return _services;
  }

  @override
  Future<List<BusStop>> fetchBusStops() async {
    final fromJson = HydratedBloc.storage.read(StorageKey.BusStops);
    _stops.clear();
    if (fromJson == null) {
      //load data from API
      final data = await HTTPRequest.loadBusStops();
      _stops.addAll(data);
      //parse data for storage
      final dynamic storage = _stops.map((e) => e.toJson()).toList();
      //save data
      HydratedBloc.storage.write(StorageKey.BusStops, jsonEncode(storage));
    } else {
      final data = jsonDecode(fromJson);
      final list = (data as List).map((e) => BusStop.fromJson(e)).toList();
      _stops.addAll(list);
    }

    return _stops;
  }

  @override
  List<BusRoute> getBusRouteByService({required String service}) =>
      _routes.where((element) => element.serviceNo == service).toList();

  @override
  List<BusService> getAllBusService() => _services;

  @override
  List<BusStop> getAllBusStops() => _stops;

  @override
  Future<List<BusRoute>> fetchBusRoutes() async {
    final fromJson = HydratedBloc.storage.read(StorageKey.BusRoutes);
    _routes.clear();
    if (fromJson == null) {
      final data = await HTTPRequest.loadBusRoutes();
      _routes.addAll(data);
      dynamic tmp = _routes.map((e) => e.toJson()).toList();
      HydratedBloc.storage.write(StorageKey.BusRoutes, jsonEncode(tmp));
    } else {
      final data = jsonDecode(fromJson);
      final list = (data as List).map((e) => BusRoute.fromJson(e)).toList();
      _routes.addAll(list);
    }
    return _routes;
  }

  @override
  Future<List<Favorite>> fetchFavorites() async {
    final fromJson = HydratedBloc.storage.read(StorageKey.Favorites);
    _favorites.clear();
    if (fromJson != null) {
      final data = jsonDecode(fromJson);
      final temp = (data as List).map((e) => Favorite.fromJson(e)).toList();
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
      // write to cache
      dynamic data = _favorites.map((e) => e.toJson()).toList();
      HydratedBloc.storage.write(StorageKey.Favorites, jsonEncode(data));
    }
    return _favorites;
  }

  @override
  List<Favorite> removeFavorite({required Favorite favorite}) {
    if (_favorites.contains(favorite)) {
      _favorites.remove(favorite);
      final data = _favorites.map((e) => e.toJson()).toList();
      HydratedBloc.storage.write(StorageKey.Favorites, data);
    }
    return _favorites;
  }

  @override
  SelectedRoute getSelectedRoute() => selected;

  @override
  void setSelectedRoute({required String code, required String service}) {
    selected = SelectedRoute(code: code, service: service);
  }

  @override
  List<BusRoute> getBusRouteByBusStop({required String code}) =>
      _routes.where((element) => element.serviceNo == code).toList();
}
