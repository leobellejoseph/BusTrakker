import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_arrival_state.dart';

class BusArrivalCubit extends Cubit<BusArrivalState> {
  BusArrivalCubit() : super(BusArrivalState.initial());
  void getBusServices(String code) async {
    emit(state.copyWith(data: [], status: Status.loading));
    try {
      List<BusArrival> data = await HTTPRequest.loadBusStopArrivals(code);
      print('$code: ${data.length}');
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
