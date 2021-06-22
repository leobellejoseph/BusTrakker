import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/models/bus_service.dart';
import 'package:my_bus/models/failure.dart';

part 'bus_service_event.dart';
part 'bus_service_state.dart';

class BusServiceBloc extends Bloc<BusServiceEvent, BusServiceState> {
  BusServiceBloc() : super(BusServiceState.initial());

  @override
  Stream<BusServiceState> mapEventToState(
    BusServiceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
