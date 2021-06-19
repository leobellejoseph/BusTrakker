part of 'bus_stop_bloc.dart';

enum BusStopStatus { initial, loading, loaded, error }

class BusStopState extends Equatable {
  final List<BusStop> data;
  final BusStopStatus status;
  const BusStopState({required this.data, required this.status});

  factory BusStopState.initial() =>
      BusStopState(data: [], status: BusStopStatus.initial);

  @override
  List<Object> get props => [this.data, this.status];
}
