import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/models/models.dart';

part 'near_stops_state.dart';

class NearStopsCubit extends Cubit<NearStopsState> {
  final BusStopBloc _busStopBloc;
  NearStopsCubit({required BusStopBloc busStopBloc})
      : _busStopBloc = busStopBloc,
        super(NearStopsState.initial());

  void showNearBusStops() {
    emit(state.copyWith(status: NearStopsStatus.loading));
    try {
      final currentData = _busStopBloc.state.data;
      if (currentData.isNotEmpty) {}
      emit(state.copyWith(data: currentData, status: NearStopsStatus.loaded));
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
