import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

part 'near_bus_state.dart';

class NearBusCubit extends Cubit<NearBusState> {
  final BusRepository _repository;
  NearBusCubit({required BusRepository busRepository})
      : _repository = busRepository,
        super(NearBusState.initial());

  void getNearMeBusStops([String query = '']) async {
    emit(state.copyWith(data: [], status: NearBusStatus.loading));
    try {
      final List<BusStop> data = [];
      final bool isLocationEnabled = await LocationRequest.isLocationEnabled();
      final LocationPermission permission =
          await LocationRequest.checkLocationPermission();
      final bool validPermission = (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse);
      if (isLocationEnabled == true && validPermission == true) {
        final _stops = _repository.getAllBusStops();
        if (_stops.isNotEmpty) {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          final newData = _stops.where((stop) {
            stop.setDistance(position);
            final _query = query.toLowerCase();
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
          emit(state.copyWith(data: data, status: NearBusStatus.loaded));
        }
      } else {
        if (isLocationEnabled == false) {
          emit(state.copyWith(data: [], status: NearBusStatus.no_location));
        } else if (validPermission == false) {
          emit(state.copyWith(data: [], status: NearBusStatus.no_permission));
        } else {
          emit(state.copyWith(data: [], status: NearBusStatus.no_data));
        }
      }
    } on Failure catch (_) {
      emit(state.copyWith(
          status: NearBusStatus.error, failure: Failure.nearBus()));
    } on TimeoutException catch (_) {
      emit(state.copyWith(data: [], status: NearBusStatus.no_data));
    }
  }
}
