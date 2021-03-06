import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_arrival_state.dart';

class BusArrivalCubit extends Cubit<BusArrivalState> {
  BusArrivalCubit() : super(BusArrivalState.initial());
  void getBusArrival(String code, String service, bool delay) async {
    emit(state.copyWith(status: BusArrivalStatus.loading));
    try {
      final bool hasInternet = await InternetConnectionChecker().hasConnection;
      if (hasInternet) {
        if (delay) {
          // wait for one second
          Future.delayed(const Duration(milliseconds: 1000), () async {
            BusArrival arrival =
                await HTTPRequest.loadBusArrivals(code, service);
            emit(
                state.copyWith(data: arrival, status: BusArrivalStatus.loaded));
          });
        } else {
          BusArrival arrival = await HTTPRequest.loadBusArrivals(code, service);
          emit(state.copyWith(data: arrival, status: BusArrivalStatus.loaded));
        }
      } else {
        emit(state.copyWith(status: BusArrivalStatus.no_internet));
      }
    } on Failure catch (_) {
      emit(
        state.copyWith(
            status: BusArrivalStatus.error, failure: Failure.arrival()),
      );
    }
  }
}
