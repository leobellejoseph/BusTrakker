part of 'bus_stop_bloc.dart';

enum BusStopStatus { initial, loading, loaded, loadNear, loadedNear, error }

class BusStopState extends Equatable {
  final List<BusStop> data;
  final BusStopStatus status;
  final Position position;
  final Failure failure;

  BusStopState copyWith({
    List<BusStop>? data,
    BusStopStatus? status,
    Position? position,
    Failure? failure,
  }) {
    return BusStopState(
      data: data ?? this.data,
      status: status ?? this.status,
      position: position ?? this.position,
      failure: failure ?? this.failure,
    );
  }

  const BusStopState({
    required this.data,
    required this.status,
    required this.position,
    required this.failure,
  });

  factory BusStopState.initial() {
    return BusStopState(
      data: [],
      status: BusStopStatus.initial,
      position: LocationRequest.defaultPosition(),
      failure: Failure.none(),
    );
  }

  @override
  List<Object> get props => [
        this.data,
        this.status,
        this.position,
        this.failure,
      ];
}
