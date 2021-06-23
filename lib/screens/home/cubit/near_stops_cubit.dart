import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'near_stops_state.dart';

class NearStopsCubit extends Cubit<NearStopsState> {
  final BusStopBloc _busStopBloc;
  NearStopsCubit({required BusStopBloc busStopBloc})
      : _busStopBloc = busStopBloc,
        super(NearStopsState.initial());

  void showNearBusStops([String query = '']) async {
    emit(state.copyWith(status: NearStopsStatus.loading));
    try {
      final currentData = _busStopBloc.state.data;
      List<BusStop> newData = [];
      Position _position = await LocationRequest.getLocationPosition();
      if (currentData.isNotEmpty) {
        newData = currentData.where(
          (data) {
            data.setDistance(_position);
            final _distance = data.distanceInt;
            final _busStopCode = data.busStopCode.toLowerCase();
            final _roadName = data.roadName.toLowerCase();
            final _description = data.description.toLowerCase();
            return _distance <= 500 &&
                _distance > 0 &&
                (_busStopCode.contains(query) ||
                    _roadName.contains(query) ||
                    _description.contains(query));
          },
        ).toList();
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
