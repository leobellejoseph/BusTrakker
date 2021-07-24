part of 'bus_arrivals_cubit.dart';

enum Status { initial, loading, loaded, error, no_service, no_internet }

class BusArrivalsState extends Equatable {
  final List<BusArrival> data;
  final Status status;
  final Failure failure;

  factory BusArrivalsState.initial() => BusArrivalsState(
        data: [],
        status: Status.initial,
        failure: Failure.none(),
      );

  BusArrivalsState copyWith({
    List<BusArrival>? data,
    Status? status,
    Failure? failure,
  }) {
    return BusArrivalsState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  BusArrivalsState({
    required this.data,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [
        this.data,
        this.status,
        this.failure,
      ];
}
