part of 'bus_stop_bloc.dart';

abstract class BusStopEvent extends Equatable {
  const BusStopEvent();
  @override
  List<Object?> get props => [];
}

class BusStopsDownload extends BusStopEvent {}

class NearBusStopsFetch extends BusStopEvent {
  final int distance;
  final Position position;
  const NearBusStopsFetch({required this.distance, required this.position});

  @override
  List<Object?> get props => [this.distance, this.position];
}
