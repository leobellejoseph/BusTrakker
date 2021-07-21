import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_arrival_state.dart';

class BusArrivalCubit extends Cubit<BusArrivalState> {
  BusArrivalCubit() : super(BusArrivalState.initial());

  void getBusArrival(String code, String service, bool delay) async {
    emit(state.copyWith(status: BusArrivalStatus.loading));
    try {
      if (delay) {
        // wait for one second
        Future.delayed(const Duration(milliseconds: 1000), () async {
          BusArrival arrival = await HTTPRequest.loadBusArrivals(code, service);
          emit(
            state.copyWith(data: arrival, status: BusArrivalStatus.loaded),
          );
        });
      } else {
        BusArrival arrival = await HTTPRequest.loadBusArrivals(code, service);
        emit(
          state.copyWith(data: arrival, status: BusArrivalStatus.loaded),
        );
      }
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: BusArrivalStatus.error,
          failure: Failure(
              code: 'Bus Arrival', message: 'Failed to fetch Bus Arrival'),
        ),
      );
    }
  }
}
