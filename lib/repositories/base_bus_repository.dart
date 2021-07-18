import 'package:my_bus/models/models.dart';

abstract class BaseBusRepository {
  Future<List<BusStop>> getNearStops(int distance);
  BusStop getBusStop(String code);
  BusService getBusService(String service);
}
