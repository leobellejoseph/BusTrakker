import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/helpers/helpers.dart';
import 'package:my_bus/models/models.dart';

part 'bus_route_state.dart';

class BusRouteCubit extends Cubit<BusRouteState> {
  BusRouteCubit() : super(BusRouteState.initial());

  void fetchRoute({required String service}) async {
    emit(state.copyWith(status: BusRouteStatus.loading));
    try {
      final routes = await HTTPRequest.loadBusRouteByService(service: service);
      emit(state.copyWith(data: routes, status: BusRouteStatus.loaded));
    } on Failure catch (_) {
      emit(state.copyWith(
          status: BusRouteStatus.error,
          failure: Failure(
              code: 'Bus Route', message: 'Unable to fetch Bus Route')));
    }
  }
}
