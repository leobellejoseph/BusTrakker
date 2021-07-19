import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_route_state.dart';

class BusRouteCubit extends Cubit<BusRouteState> {
  final BusDataBloc busDataBloc;
  final List<BusStop> _stops = [];
  final List<BusService> _services = [];

  BusRouteCubit({required this.busDataBloc}) : super(BusRouteState.initial()) {
    _stops.addAll(busDataBloc.state.stopsData);
    _services.addAll(busDataBloc.state.serviceData);
  }

  BusStop fetchBusStopInfo(String code) =>
      _stops.where((element) => element.busStopCode == code).first;

  BusService fetchBusServiceInfo(String service) =>
      _services.where((element) => element.serviceNo == service).first;

  void fetchRoute({required String service, String code = ''}) async {
    emit(state.copyWith(data: [], status: BusRouteStatus.loading));
    try {
      final routes = await HTTPRequest.loadBusRouteByService(service: service);
      final directionRoute =
          routes.where((element) => element.busStopCode.contains(code)).first;
      final filtered = routes
          .where((element) => element.direction == directionRoute.direction)
          .toList();
      emit(state.copyWith(data: filtered, status: BusRouteStatus.loaded));
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error,
          failure: Failure(
              code: 'Bus Route', message: 'Unable to fetch Bus Route')));
    }
  }
}
