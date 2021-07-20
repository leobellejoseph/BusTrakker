import 'package:my_bus/models/models.dart';

abstract class BaseBusRepository {
  List<BusStop> getNearStops(int distance);
  List<BusRoute> getBusRoute({required String service, String code = ''});
  List<BusStop> getAllBusStops();
  List<BusService> getAllBusService();
  Favorite getFavorite({required String service,required String code});
  BusStop getBusStop(String code);
  BusService getBusService(String service);
  Future<List<BusStop>> fetchBusStops();
  Future<List<BusService>> fetchBusServices();
  Future<List<BusRoute>> fetchBusRoutes();
  Future<List<Favorite>> fetchFavorites();
  bool isFavorite({required String service,required String code});
}
