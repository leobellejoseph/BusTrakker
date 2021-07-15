import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_arrivals_state.dart';

class BusArrivalsCubit extends Cubit<BusArrivalsState> {
  BusArrivalsCubit() : super(BusArrivalsState.initial());
  void getBusServices(String code) async {
    emit(state.copyWith(data: [], status: Status.loading));
    try {
      List<BusArrival> data = await HTTPRequest.loadBusStopArrivals(code);
      if (data.isNotEmpty)
        emit(state.copyWith(data: data, status: Status.loaded));
      else
        emit(state.copyWith(data: data, status: Status.no_service));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: Status.error,
          failure: Failure(
              code: 'Bus Arrival',
              message: 'Failed to fetch Bus Arrival Services'),
        ),
      );
    }
  }
}
