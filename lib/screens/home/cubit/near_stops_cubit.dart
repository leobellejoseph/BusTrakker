import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'near_stops_state.dart';

class NearStopsCubit extends Cubit<NearStopsState> {
  final BusDataBloc _busData;
  NearStopsCubit({required BusDataBloc busData})
      : _busData = busData,
        super(NearStopsState.initial()) {
    _busData.stream.listen((state) {
      if (state.status == BusDataStatus.busStopsLoaded && stopsData.isEmpty) {
        stopsData.addAll(state.stopsData);
      }
    });
  }
  List<BusStop> stopsData = [];
  void showNearBusStops([String query = '']) async {
    emit(state.copyWith(status: NearStopsStatus.loading));
    try {
      final currentData = stopsData;
      List<BusStop> newData = [];
      Position _position = await LocationRequest.getLocationPosition();
      if (currentData.isNotEmpty) {
        currentData.map((e) => e.setDistance(_position));
        newData = currentData.where((data) {
          data.setDistance(_position);
          final _query = query.toLowerCase();
          final _distance = data.distanceInt;
          final _busStopCode = data.busStopCode.toLowerCase();
          final _roadName = data.roadName.toLowerCase();
          final _description = data.description.toLowerCase();
          return data.distanceInt < 400 &&
              (_busStopCode.contains(_query) ||
                  _roadName.contains(_query) ||
                  _description.contains(_query));
        }).toList()
          ..sort((a, b) => a.distanceInt - b.distanceInt);
      }
      emit(state.copyWith(data: newData, status: NearStopsStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: NearStopsStatus.error,
          failure: Failure(
              code: 'NearBusStops', message: 'Failed to fetch Near Bus Stops.'),
        ),
      );
    }
  }
}
