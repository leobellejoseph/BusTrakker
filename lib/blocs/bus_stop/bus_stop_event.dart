part of 'bus_stop_bloc.dart';

abstract class BusStopEvent extends Equatable {
  const BusStopEvent();
  @override
  List<Object?> get props => [];
}

class BusStopDownload extends BusStopEvent {}

class BusStopNear extends BusStopEvent {
  final int distance;
  const BusStopNear({required this.distance});
}
