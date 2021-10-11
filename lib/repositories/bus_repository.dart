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
  void updateFavoriteDescription({required Favorite favorite}) {
    for (final fave in _favorites) {
      if (fave == favorite) {}
    }
  }

  @override
  List<BusStop> getNearStops() {
    return _stops;
  }

  @override
  BusService getBusService(String service) {
    final list = _services.where((element) => element.serviceNo == service);
    if (list.isNotEmpty) {
      return list.first;
    }
    return BusService.empty();
  }

  @override
  BusStop getBusStop(String code) {
    return _stops.firstWhere(
      (element) => element.busStopCode == code,
      orElse: () => BusStop.empty(),
    );
  }

  @override
  Future<List<BusService>> fetchBusServices() async {
    dynamic fromJson = HydratedBloc.storage.read(StorageKey.BusServices);
    _services.clear();
    if (fromJson == null) {
      final data = await HTTPRequest.loadBusServices();
      _services.addAll(data);
      final list = _services.map((e) => e.toJson()).toList();
      if (list.isNotEmpty) {
        HydratedBloc.storage.write(StorageKey.BusServices, jsonEncode(list));
      }
    } else {
      final data = jsonDecode(fromJson);
      final List<BusService> list =
          (data as List).map((e) => BusService.fromJson(e)).toList();
      if (list.isNotEmpty) {
        _services.addAll(list);
      }
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
    _routes.clear();
    final fromJson = HydratedBloc.storage.read(StorageKey.BusRoutes);
    if (fromJson == null) {
      final data = await HTTPRequest.loadBusRoutes();
      _routes.addAll(data);
      HydratedBloc.storage.write(StorageKey.BusRoutes, jsonEncode(_routes));
    } else {
      final data = jsonDecode(fromJson);
      if (data != null && data is List && data.isNotEmpty) {
        _routes.addAll(data.map((e) => BusRoute.fromJson(e)).toList());
      }
    }
    return _routes;
  }

  @override
  Future<List<Favorite>> fetchFavorites() async {
    _favorites.clear();
    final json = HydratedBloc.storage.read(StorageKey.Favorites);
    if (json != null) {
      final data = jsonDecode(json);
      final list = (data as List).map((e) => Favorite.fromJson(e)).toList();
      _favorites.addAll(list);
    }
    return _favorites;
  }

  @override
  Favorite? getFavorite(String service, String code) => _favorites.firstWhere(
        (item) => item.serviceNo == service && item.busStopCode == code,
        orElse: () => Favorite.empty(),
      );

  @override
  bool isFavorite({required String service, required String code}) => _favorites
      .where((e) => e.busStopCode == code && e.serviceNo == service)
      .isNotEmpty;

  @override
  bool favoriteExists({required Favorite favorite}) {
    return _favorites.where((item) => item == favorite).isNotEmpty;
  }

  @override
  List<Favorite> addFavorite({required Favorite favorite}) {
    print('add favorite');
    if (!_favorites.contains(favorite)) {
      _favorites.add(favorite);
      HydratedBloc.storage.write(StorageKey.Favorites, jsonEncode(_favorites));
    }
    return _favorites;
  }

  @override
  List<Favorite> removeFavorite({required Favorite favorite}) {
    if (_favorites.contains(favorite)) {
      _favorites.remove(favorite);
      HydratedBloc.storage.write(StorageKey.Favorites, jsonEncode(_favorites));
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
  List<BusRoute> getBusRouteByBusStop({required String code}) {
    return _routes.where((element) => element.busStopCode == code).toList();
  }

  @override
  List<BusService> getBusServices(String code) {
    final list = _routes
        .where((element) => element.busStopCode == code)
        .toSet()
        .map((e) => getBusService(e.serviceNo))
        .toSet()
        .toList();
    return list;
  }

  @override
  void setBusStopService({required String code, required String services}) {
    final stop = _stops.firstWhere((element) => element.busStopCode == code);
    stop.keywords.add(services);
  }

  @override
  String toString() => 'bus_repository.dart';
}
