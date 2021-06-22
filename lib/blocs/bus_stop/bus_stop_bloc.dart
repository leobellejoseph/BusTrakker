import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_stop_event.dart';
part 'bus_stop_state.dart';

class BusStopBloc extends Bloc<BusStopEvent, BusStopState> {
  BusStopBloc() : super(BusStopState.initial());

  @override
  Stream<BusStopState> mapEventToState(
    BusStopEvent event,
  ) async* {
    final currentState = state;
    if (event is BusStopsDownload) {
      yield* _mapBusStopDownloadEventState(currentState);
    } else if (event is NearBusStopsFetch) {
      yield* _mapBusStopNearEventState(currentState, event);
    }
  }

  Stream<BusStopState> _mapBusStopDownloadEventState(
      BusStopState state) async* {
    yield state.copyWith(
      status: BusStopStatus.loading,
    );
    try {
      final data = await HTTPRequest.loadBusStops();
      yield state.copyWith(
        data: data,
        status: BusStopStatus.loaded,
      );
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusStopStatus.error,
        failure:
            Failure(code: 'BusStop', message: 'Failed to Download Bus Stops'),
      );
    }
  }

  Stream<BusStopState> _mapBusStopNearEventState(
      BusStopState state, NearBusStopsFetch event) async* {
    try {
      yield state.copyWith(
        status: BusStopStatus.loadNear,
      );
      final currentData = state.data;
      List<BusStop> newData = [];
      currentData.forEach((data) {
        data.setDistance(event.position);
        if (data.distanceInt <= event.distance) newData.add(data);
      });
      print(newData.length);
      yield state.copyWith(
        data: newData,
        status: BusStopStatus.loadedNear,
        failure: Failure.none(),
      );
    } on Failure catch (_) {
      yield state.copyWith(
        status: BusStopStatus.error,
        failure:
            Failure(code: 'BusStop', message: 'Failed to Download Bus Stops'),
      );
    }
  }
}
