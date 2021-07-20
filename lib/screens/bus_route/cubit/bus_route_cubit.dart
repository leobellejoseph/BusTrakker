import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

part 'bus_route_state.dart';

class BusRouteCubit extends Cubit<BusRouteState> {
  final BusRepository _busRepository;
  BusRouteCubit({required BusRepository busRepository})
      : _busRepository = busRepository,
        super(BusRouteState.initial());
  void fetchAllRoutes() async {
    emit(state.copyWith(data: [], status: BusRouteStatus.loading_all));
    try {
      final data = await _busRepository.fetchBusRoutes();
      print('Fetching routes completed: ${data.length}');
      emit(state.copyWith(data: data, status: BusRouteStatus.loaded_all));
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error,
          failure: Failure(
              code: 'Bus Route', message: 'Unable to fetch All Bus Route')));
    }
  }

  void fetchRoute({required String service, String code = ''}) async {
    final currentState = state;
    emit(state.copyWith(data: [], status: BusRouteStatus.loading));
    try {
      if (currentState.status == BusRouteStatus.loaded_all ||
          currentState.status == BusRouteStatus.loaded) {
        final routes = _busRepository.getBusRoute(service: service, code: code);
        if (routes.isNotEmpty) {
          final directionRoute = routes
              .where((element) => element.busStopCode.contains(code))
              .first;
          final filtered = routes
              .where((element) => element.direction == directionRoute.direction)
              .toList();
          emit(state.copyWith(data: filtered, status: BusRouteStatus.loaded));
        } else {
          emit(state.copyWith(data: [], status: BusRouteStatus.no_data));
        }
      } else {
        emit(state.copyWith(data: [], status: BusRouteStatus.loading_all));
      }
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error,
          failure: Failure(
              code: 'Bus Route', message: 'Unable to fetch Bus Route')));
    }
  }
}
