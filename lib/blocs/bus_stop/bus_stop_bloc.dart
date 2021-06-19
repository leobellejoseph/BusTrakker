import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/models/models.dart';

part 'bus_stop_event.dart';
part 'bus_stop_state.dart';

class BusStopBloc extends Bloc<BusStopEvent, BusStopState> {
  BusStopBloc() : super(BusStopState.initial());

  @override
  Stream<BusStopState> mapEventToState(
    BusStopEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
