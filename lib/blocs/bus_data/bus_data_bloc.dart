import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_data_event.dart';
part 'bus_data_state.dart';

class BusDataBloc extends Bloc<BusDataEvent, BusDataState> {
  BusDataBloc() : super(BusDataState.initial());

  List<BusStop> _stops = [];
  List<BusService> _services = [];

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
    } else if (event is NearBusStopsFetch) {
      yield* _mapEventNearBusStopsToState(event);
    }
  }

  Stream<BusDataState> _mapEventNearBusStopsToState(
      NearBusStopsFetch event) async* {
    yield state.copyWith(status: BusDataStatus.nearBusStopsLoading);
    try {
      final List<BusStop> data = [];
      if (_stops.isNotEmpty) {
        Position _position = await LocationRequest.getLocationPosition();
        final newData = _stops.where((stop) {
          stop.setDistance(_position);
          final _query = event.query.toLowerCase();

          final _busStopCode = stop.busStopCode.toLowerCase();
          final _roadName = stop.roadName.toLowerCase();
          final _description = stop.description.toLowerCase();
          return stop.distanceInt < 400 &&
              (_busStopCode.contains(_query) ||
                  _roadName.contains(_query) ||
                  _description.contains(_query));
        }).toList()
          ..sort((a, b) => a.distanceInt - b.distanceInt);
        data.addAll(newData);
      }
      yield state.copyWith(
        nearData: data,
        status: BusDataStatus.nearBusStopsLoaded,
      );
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusDataStatus.error,
        failure: Failure(
          code: 'Bus Stops',
          message: 'Unable to fetch Near Bus Stops',
        ),
      );
    }
    // TODO: implement mapEventToState
  }

  Stream<BusDataState> _mapEventBusStopsToState() async* {
    yield state.copyWith(status: BusDataStatus.busStopsLoading);
    try {
      final data = await HTTPRequest.loadBusStops();
      _stops.addAll(data);
      yield state.copyWith(
        stopsData: data,
        status: BusDataStatus.busStopsLoaded,
      );
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusDataStatus.error,
        failure: Failure(
          code: 'Bus Stops',
          message: 'Unable to download Bus Stops',
        ),
      );
    }
    // TODO: implement mapEventToState
  }

  Stream<BusDataState> _mapEventBusServiceToState() async* {
    yield state.copyWith(status: BusDataStatus.busServiceLoading);
    try {
      final data = await HTTPRequest.loadBusServices();
      _services.addAll(data);
      yield state.copyWith(
          serviceData: data, status: BusDataStatus.busServiceLoaded);
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusDataStatus.error,
        failure: Failure(
          code: 'Bus Service',
          message: 'Unable to download Bus Services',
        ),
      );
    }
  }

  Stream<BusDataState> _mapEventBusStopsFetchToState(
      BusStopFetch event) async* {
    yield state.copyWith(status: BusDataStatus.busStopsLoading);
    try {
      final query = event.query.toLowerCase();
      final data = _stops.where(
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
        status: BusDataStatus.error,
        failure: Failure(
          code: 'Bus Stops',
          message: 'Unable to fetch Bus Stops',
        ),
      );
    }
  }

  Stream<BusDataState> _mapEventBusServiceFetchToState(
      BusServiceFetch event) async* {
    yield state.copyWith(status: BusDataStatus.busServiceLoading);
    try {
      final _query = event.query.toLowerCase();
      final data = _services
          .where((element) => element.serviceNo.contains(_query))
          .toList();
      yield state.copyWith(
        serviceData: data,
        status: BusDataStatus.busServiceLoaded,
      );
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusDataStatus.error,
        failure: Failure(
          code: 'Bus Service',
          message: 'Unable to fetch Bus Services',
        ),
      );
    }
  }
}
