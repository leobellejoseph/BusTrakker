part of 'bus_route_cubit.dart';

enum BusRouteStatus { initial, loading, loaded, error }

class BusRouteState extends Equatable {
  final List<BusRoute> data;
  final BusRouteStatus status;
  final Failure failure;

  BusRouteState(
      {required this.data, required this.status, required this.failure});

  factory BusRouteState.initial() => BusRouteState(
        data: [],
        status: BusRouteStatus.initial,
        failure: Failure.none(),
      );

  BusRouteState copyWith({
    List<BusRoute>? data,
    BusRouteStatus? status,
    Failure? failure,
  }) {
    return BusRouteState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [this.data, this.status, this.failure];
}
