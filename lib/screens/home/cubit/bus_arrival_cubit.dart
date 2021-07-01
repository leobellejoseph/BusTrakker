import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_arrival_state.dart';

class BusArrivalCubit extends Cubit<BusArrivalState> {
  BusArrivalCubit() : super(BusArrivalState.initial());

  void fetchArrivalByBusStop(String query) async {
    emit(state.copyWith(status: BusArrivalStatus.loading));
    try {
      final data = await HTTPRequest.loadBusStopArrivals(query);
      emit(state.copyWith(data: data, status: BusArrivalStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: BusArrivalStatus.error,
          failure: Failure(
              code: 'Bus Arrival', message: 'Unable to fetch Bus Arrival'),
        ),
      );
    }
  }

  void fetchServicesByBusStop(String query) async {
    emit(state.copyWith(status: BusArrivalStatus.loading));
    try {
      final data = await HTTPRequest.loadBusStopArrivals(query);
      emit(state.copyWith(data: data, status: BusArrivalStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: BusArrivalStatus.error,
          failure: Failure(
              code: 'Bus Arrival', message: 'Unable to fetch Bus Arrival'),
        ),
      );
    }
  }

  void fetchArrivalByBusStopAndService(String stop, String service) async {
    emit(state.copyWith(status: BusArrivalStatus.loading));
    try {
      final data = await HTTPRequest.loadBusArrivals(stop, service);
      List<BusArrival> list = [data];
      emit(state.copyWith(data: list, status: BusArrivalStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: BusArrivalStatus.error,
          failure: Failure(
              code: 'Bus Arrival', message: 'Unable to fetch Bus Arrival'),
        ),
      );
    }
  }
}
