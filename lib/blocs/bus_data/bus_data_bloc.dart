import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

part 'bus_data_event.dart';
part 'bus_data_state.dart';

class BusDataBloc extends Bloc<BusDataEvent, BusDataState> {
  final BusRepository busRepository;
  BusDataBloc({required this.busRepository}) : super(BusDataState.initial());
  @override
  Stream<BusDataState> mapEventToState(
    BusDataEvent event,
  ) async* {
    if (event is BusDataDownload) {
      // load Bus Stops
      yield* _mapEventBusStopsToState();
      // load Bus Services
      yield* _mapEventBusServiceToState();
      // inform UI that all is loaded
      yield state.copyWith(status: BusDataStatus.allLoaded);
    } else if (event is BusStopFetch) {
      yield* _mapEventBusStopsFetchToState(event);
    } else if (event is BusServiceFetch) {
      yield* _mapEventBusServiceFetchToState(event);
    }
  }

  Stream<BusDataState> _mapEventBusStopsToState() async* {
    yield state.copyWith(status: BusDataStatus.busStopsLoading);
    try {
      final data = await busRepository.fetchBusStops();
      final bool isConnected = await InternetConnectionChecker().hasConnection;
      if (data.isEmpty && isConnected == false) {
        yield state.copyWith(status: BusDataStatus.no_internet);
      } else {
        yield state.copyWith(
            stopsData: data, status: BusDataStatus.busStopsLoaded);
      }
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusDataStatus.error,
        failure: Failure.stops(),
      );
    }
    // TODO: implement mapEventToState
  }

  Stream<BusDataState> _mapEventBusServiceToState() async* {
    yield state.copyWith(status: BusDataStatus.busServiceLoading);
    try {
      final data = await busRepository.fetchBusServices();
      final dir1 = data.where((element) => element.direction == 1).toList();
      final bool isConnected = await InternetConnectionChecker().hasConnection;
      if (data.isEmpty && isConnected == false) {
        yield state.copyWith(
            serviceData: dir1, status: BusDataStatus.no_internet);
      } else {
        yield state.copyWith(
            serviceData: dir1, status: BusDataStatus.busServiceLoaded);
      }
    } on Failure catch (_) {
      yield state.copyWith(
          status: BusDataStatus.error, failure: Failure.service());
    }
  }

  Stream<BusDataState> _mapEventBusStopsFetchToState(
      BusStopFetch event) async* {
    yield state.copyWith(status: BusDataStatus.busStopsLoading);
    try {
      final query = event.query.toLowerCase();
      final stops = busRepository.getAllBusStops();
      final data = stops.where(
        (element) {
          final code = element.busStopCode.toLowerCase();
          final road = element.roadName.toLowerCase();
          final desc = element.description.toLowerCase();
          return code.contains(query) ||
              road.contains(query) ||
              desc.contains(query);
        },
      ).toList();
      yield state.copyWith(
        stopsData: data,
        status: BusDataStatus.busStopsLoaded,
      );
    } on Failure catch (_) {
      yield state.copyWith(
          status: BusDataStatus.error, failure: Failure.stops());
    }
  }

  Stream<BusDataState> _mapEventBusServiceFetchToState(
      BusServiceFetch event) async* {
    yield state.copyWith(status: BusDataStatus.busServiceLoading);
    try {
      final query = event.query.toLowerCase();
      final services = busRepository.getAllBusService();
      final data = services
          .where((element) => element.serviceNo.contains(query))
          .toList();
      yield state.copyWith(
          serviceData: data, status: BusDataStatus.busServiceLoaded);
    } on Failure catch (_) {
      yield state.copyWith(
          status: BusDataStatus.error, failure: Failure.service());
    }
  }
}
