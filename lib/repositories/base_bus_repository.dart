import 'package:my_bus/models/models.dart';

abstract class BaseBusRepository {
  List<BusStop> getNearStops();
  List<BusRoute> getBusRouteByService({required String service});
  List<BusRoute> getBusRouteByBusStop({required String code});
  List<BusStop> getAllBusStops();
  List<BusService> getAllBusService();
  Favorite? getFavorite(String service, String code);
  BusStop getBusStop(String code);
  BusService getBusService(String service);
  List<BusService> getBusServices(String code);
  Future<List<BusStop>> fetchBusStops();
  Future<List<BusService>> fetchBusServices();
  Future<List<BusRoute>> fetchBusRoutes();
  Future<List<Favorite>> fetchFavorites();
  bool isFavorite({required String service, required String code});
  bool favoriteExists({required Favorite favorite});
  List<Favorite> removeFavorite({required Favorite favorite});
  List<Favorite> addFavorite({required Favorite favorite});
  SelectedRoute getSelectedRoute();
  void setSelectedRoute({required String code, required String service});
  void updateFavoriteDescription({required Favorite favorite});
  void setBusStopService({required String code, required String services});
}
