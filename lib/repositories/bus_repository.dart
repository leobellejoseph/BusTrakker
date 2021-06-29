import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/base_bus_repository.dart';

class BusRepository extends BaseBusRepository {
  List<BusStop> _busStops = [];
  //List<BusService> _busServices = [];
  @override
  Future<List<BusStop>> getNearStops(int distance) async {
    return _busStops;
  }
}
