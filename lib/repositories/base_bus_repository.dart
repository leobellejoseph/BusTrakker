import 'package:my_bus/models/models.dart';

abstract class BaseBusRepository {
  Future<List<BusStop>> getNearStops(int distance);
}
