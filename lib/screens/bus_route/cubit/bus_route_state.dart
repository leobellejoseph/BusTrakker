part of 'bus_route_cubit.dart';

enum BusRouteStatus {
  initial,
  loading,
  loaded,
  error,
  no_data,
  loading_all,
  loaded_all,
}

class BusRouteState extends Equatable {
  final List<BusRoute> data;
  final BusRouteStatus status;
  final int direction;
  final String begin;
  final String end;
  final Failure failure;

  BusRouteState(
      {required this.data,
      required this.status,
      required this.direction,
      required this.begin,
      required this.end,
      required this.failure});

  factory BusRouteState.initial() => BusRouteState(
        data: [],
        status: BusRouteStatus.initial,
        direction: 0,
        begin: '',
        end: '',
        failure: Failure.none(),
      );

  BusRouteState copyWith({
    List<BusRoute>? data,
    BusRouteStatus? status,
    int? direction,
    String? begin,
    String? end,
    Failure? failure,
  }) {
    return BusRouteState(
      data: data ?? this.data,
      status: status ?? this.status,
      direction: direction ?? this.direction,
      begin: begin ?? this.begin,
      end: end ?? this.begin,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [
        this.data,
        this.status,
        this.direction,
        this.begin,
        this.end,
        this.failure,
      ];
}
