import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/base_bus_repository.dart';

class BusRepository extends BaseBusRepository {
  final BusDataBloc busDataBloc;
  BusRepository({required this.busDataBloc}) {
    busDataBloc.stream.listen((event) {
      if (busDataBloc.state.status == BusDataStatus.busStopsLoaded) {
        print('repository bus stop');
        _busStops.addAll(busDataBloc.state.stopsData);
      }
      if (busDataBloc.state.status == BusDataStatus.busServiceLoaded) {
        print('repository bus services');
        _busServices.addAll(busDataBloc.state.serviceData);
      }
    });
  }

  List<BusStop> _busStops = [];
  List<BusService> _busServices = [];
  @override
  Future<List<BusStop>> getNearStops(int distance) async {
    return _busStops;
  }

  @override
  BusService getBusService(String service) {
    // TODO: implement getBusService
    throw UnimplementedError();
  }

  @override
  BusStop getBusStop(String code) {
    // TODO: implement getBusStop
    throw UnimplementedError();
  }
}
