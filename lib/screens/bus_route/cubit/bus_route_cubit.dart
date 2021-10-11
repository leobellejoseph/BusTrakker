import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

part 'bus_route_state.dart';

class BusRouteCubit extends Cubit<BusRouteState> {
  final BusRepository busRepository;
  BusRouteCubit({required this.busRepository}) : super(BusRouteState.initial());
  void fetchAllRoutes() async {
    emit(state.copyWith(data: [], status: BusRouteStatus.loading_all));
    try {
      final data = await busRepository.fetchBusRoutes();
      if (data.isNotEmpty) {
        Future.microtask(() {
          data.forEach(
            (element) => busRepository.setBusStopService(
                code: element.busStopCode, services: element.serviceNo),
          );
        });
      }
      emit(state.copyWith(data: data, status: BusRouteStatus.loaded_all));
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error, failure: Failure.route()));
    }
  }

  void fetchServices({required String code}) {
    emit(state.copyWith(data: [], status: BusRouteStatus.loading));
    try {
      final routes = busRepository.getBusRouteByBusStop(code: code);
      if (routes.isEmpty) {
        emit(state.copyWith(data: routes, status: BusRouteStatus.no_data));
      } else {
        emit(state.copyWith(data: routes, status: BusRouteStatus.loaded));
      }
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error, failure: Failure.route()));
    }
  }

  void fetchRoute({required String service, String code = ''}) async {
    final currentState = state;
    emit(state.copyWith(data: [], status: BusRouteStatus.loading));
    try {
      if (currentState.status == BusRouteStatus.loading_all) {
        emit(state.copyWith(data: [], status: BusRouteStatus.loading_all));
      } else {
        final routes = busRepository.getBusRouteByService(service: service);
        if (routes.isNotEmpty) {
          final List<BusRoute> filtered = [];
          int direction = 1;
          if (code.isNotEmpty) {
            // check the direction
            final directionRoute =
                routes.where((element) => element.busStopCode == code).first;
            direction = directionRoute.direction;
            final temp = routes
                .where(
                    (element) => element.direction == directionRoute.direction)
                .toList();
            filtered.addAll(temp);
          } else {
            final temp = routes
                .where((element) => element.direction == direction)
                .toList();
            filtered.addAll(temp);
          }
          final begin = busRepository.getBusStop(filtered.first.busStopCode);
          final end = busRepository.getBusStop(filtered.last.busStopCode);

          emit(state.copyWith(
              data: filtered,
              begin: begin.description,
              end: end.description,
              status: BusRouteStatus.loaded,
              direction: direction));
        } else {
          emit(state.copyWith(data: [], status: BusRouteStatus.no_data));
        }
      }
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error, failure: Failure.route()));
    }
  }

  void toggleRoute({required String service}) {
    final currentState = state;
    emit(state.copyWith(data: [], status: BusRouteStatus.loading));
    try {
      final routes = busRepository.getBusRouteByService(service: service);
      if (routes.isNotEmpty) {
        final direction =
            currentState.direction == 0 || currentState.direction == 2 ? 1 : 2;

        final filtered =
            routes.where((element) => element.direction == direction).toList();
        if (filtered.isNotEmpty) {
          final begin = busRepository.getBusStop(filtered.first.busStopCode);
          final end = busRepository.getBusStop(filtered.last.busStopCode);
          emit(state.copyWith(
              data: filtered,
              begin: begin.description,
              end: end.description,
              status: BusRouteStatus.loaded,
              direction: direction));
        } else {
          emit(state.copyWith(
              data: [], end: 'No Route', status: BusRouteStatus.no_data));
        }
      } else {
        emit(state.copyWith(data: [], status: BusRouteStatus.no_data));
      }
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error, failure: Failure.route()));
    }
  }
}
