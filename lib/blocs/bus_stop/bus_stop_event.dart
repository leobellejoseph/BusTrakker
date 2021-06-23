part of 'bus_stop_bloc.dart';

abstract class BusStopEvent extends Equatable {
  const BusStopEvent();
  @override
  List<Object?> get props => [];
}

class BusStopsDownload extends BusStopEvent {}
