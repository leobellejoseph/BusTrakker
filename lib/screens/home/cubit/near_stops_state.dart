part of 'near_stops_cubit.dart';

enum NearStopsStatus { initial, loading, loaded, error }

class NearStopsState extends Equatable {
  final List<BusStop> data;
  final NearStopsStatus status;
  final Failure failure;

  NearStopsState copyWith({
    List<BusStop>? data,
    NearStopsStatus? status,
    Failure? failure,
  }) {
    return NearStopsState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  const NearStopsState(
      {required this.data, required this.status, required this.failure});

  factory NearStopsState.initial() => NearStopsState(
      data: [], status: NearStopsStatus.initial, failure: Failure.none());

  @override
  List<Object> get props => [this.data, this.status, this.failure];
}
