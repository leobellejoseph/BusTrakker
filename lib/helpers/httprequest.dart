import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/settings/settings.dart';

class StorageKey {
  static const BusStops = 'busstops';
  static const BusServices = 'busservices';
  static const BusRoutes = 'busroutes';
  static const Favorites = 'favorites';
}

class HTTPRequest {
  static Future<dynamic> getRequest(String url) async {
    dynamic data;
    try {
      const headers = {
        'AccountKey': APISettings.ApiKey,
        'accept': APISettings.contentType,
      };
      final client = RetryClient(http.Client());
      final uri = Uri.parse(url);
      final response = await client.get(uri, headers: headers);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      }
    } catch (e) {
      data = 'nodata';
    }
    return data;
  }

  static Future<List<BusStop>> loadBusStops([String query = '']) async {
    List<BusStop> _stops = [];
    try {
      final String baseUrl = APISettings.stopsUrl;
      int skip = 0;
      while (skip < 10000) {
        final String url =
            baseUrl + (skip == 0 ? '' : '\$skip=${skip.toString()}');
        final dynamic resp = await HTTPRequest.getRequest(url);
        if (resp == 'nodata' || resp == null) break;
        final dynamic data = resp['value'];
        if (data == null) break;
        List<BusStop> stops =
            (data as List).map((e) => BusStop.fromJson(e)).toList();
        _stops.addAll(stops);
        skip += 500;
      }
    } catch (e) {
      print('Load Bus Stops: $e');
    }
    return _stops;
  }

  static Future<List<BusService>> loadBusServices([String query = '']) async {
    List<BusService> _services = [];
    try {
      final String baseUrl = APISettings.serviceUrl;
      int skip = 0;
      while (skip < 10000) {
        final String url =
            baseUrl + (skip == 0 ? '' : '\$skip=${skip.toString()}');
        final dynamic resp = await HTTPRequest.getRequest(url);
        if (resp == null) break;
        final dynamic services = resp['value'];
        if (services == null) break;
        final svcs = (services as List)
            .map((e) => BusService.fromJson(e))
            .toList()
            .where((element) => element.direction == 1)
            .toList();
        _services.addAll(svcs);
        skip += 500;
      }
    } catch (e) {
      print('Load Bus Services: $e');
    }
    return _services;
  }

  static Future<List<BusArrival>> loadBusStopArrivals(
      String busStopCode) async {
    List<BusArrival> _arrivals = [];
    try {
      if (busStopCode.isEmpty) return _arrivals;
      final String baseUrl = APISettings.arrivalUrl;
      final String url = baseUrl;
      final String param1 = 'BusStopCode=$busStopCode';
      final dynamic resp = await HTTPRequest.getRequest(url + param1);
      if (resp == 'nodata') return _arrivals;
      if (resp['BusStopCode'] == null || resp['Services'] == null)
        return _arrivals;
      final String busStop = resp['BusStopCode'];
      final dynamic arrivals = resp['Services'];
      _arrivals = (arrivals as List)
          .map((e) => BusArrival.fromJson(busStop, e))
          .toList();
    } catch (e) {
      print('Load Bus Arrivals: $e');
    }
    return _arrivals;
  }

  static Future<BusArrival> loadBusArrivals(
      String busStopCode, String serviceNo) async {
    assert(busStopCode.isNotEmpty);
    assert(serviceNo.isNotEmpty);
    BusArrival _arrival = BusArrival.empty();
    try {
      if (busStopCode.isEmpty || serviceNo.isEmpty) return _arrival;

      final String baseUrl = APISettings.arrivalUrl;
      final String param1 = 'BusStopCode=$busStopCode';
      final String param2 = '&ServiceNo=$serviceNo';
      final String url = baseUrl + param1 + param2;
      final dynamic resp = await HTTPRequest.getRequest(url);
      if (resp == 'nodata') return _arrival;
      if (resp['BusStopCode'] == null || resp['Services'] == null)
        return _arrival;
      final String busStop = resp['BusStopCode'];
      final services = resp['Services'];
      _arrival =
          (services as List).map((e) => BusArrival.fromJson(busStop, e)).first;
    } catch (e) {
      print('$busStopCode : Error Loading Arrivals: $e');
    }
    return _arrival;
  }

  static Future<List<BusRoute>> loadBusRoutes([String query = '']) async {
    List<BusRoute> _routes = [];
    try {
      final String baseUrl = APISettings.routesUrl;
      int skip = 0;
      while (skip < 30000) {
        final String url =
            baseUrl + (skip == 0 ? '' : '\$skip=${skip.toString()}');
        final dynamic resp = await HTTPRequest.getRequest(url);
        if (resp == null) break;
        final dynamic data = resp['value'];
        if (data == null) break;
        List<BusRoute> routes =
            (data as List).map((e) => BusRoute.fromJson(e)).toList();
        _routes.addAll(routes);
        skip += 500;
      }
    } catch (e) {
      print('Load Bus Routes: $e');
    }
    return _routes;
  }

  static Future<List<BusRoute>> loadBusRouteByService(
      {required String service}) async {
    List<BusRoute> _routes = [];
    try {
      final String baseUrl = APISettings.routesUrl;
      int skip = 0;
      bool flag = true;
      while (skip < 30000 || flag) {
        final String url =
            baseUrl + (skip == 0 ? '' : '\$skip=${skip.toString()}');
        final dynamic resp = await HTTPRequest.getRequest(url);
        if (resp == 'nodata' || resp['value'] == null) flag = false;
        final dynamic routes = resp['value'];
        if (routes == null || (routes as List).length == 0) break;
        final data = routes.map((e) => BusRoute.fromJson(e)).where((element) {
          return element.serviceNo == service;
        }).toList();
        _routes.addAll(data);
        skip += 500;
      }
    } catch (e) {
      print(e);
    }
    return _routes;
  }
}
