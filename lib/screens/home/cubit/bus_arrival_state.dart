part of 'bus_arrival_cubit.dart';

enum BusArrivalStatus { initial, loaded, loading, error }

class BusArrivalState extends Equatable {
  final List<BusArrival> data;
  final BusArrivalStatus status;
  final Failure failure;

  factory BusArrivalState.initial() => BusArrivalState(
        data: [],
        status: BusArrivalStatus.initial,
        failure: Failure.none(),
      );

  BusArrivalState copyWith({
    List<BusArrival>? data,
    BusArrivalStatus? status,
    Failure? failure,
  }) {
    return BusArrivalState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  const BusArrivalState(
      {required this.data, required this.status, required this.failure});

  @override
  List<Object> get props => [this.data, this.status, this.failure];
}
