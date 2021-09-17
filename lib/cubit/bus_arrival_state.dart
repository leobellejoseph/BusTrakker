part of 'bus_arrival_cubit.dart';

enum BusArrivalStatus {
  initial,
  loading,
  loaded,
  error,
  no_service,
  no_internet,
}

extension on BusArrivalStatus {
  String get name {
    switch (this) {
      case BusArrivalStatus.initial:
        return 'initial';
      case BusArrivalStatus.loading:
        return 'loading';
      case BusArrivalStatus.loaded:
        return 'loaded';
      case BusArrivalStatus.no_service:
        return 'no service';
      case BusArrivalStatus.no_internet:
        return 'no internet';
      case BusArrivalStatus.error:
        return 'error';
      default:
        return 'NA';
    }
  }
}

class BusArrivalState extends Equatable {
  final BusArrival data;
  final BusArrivalStatus status;
  final Failure failure;

  factory BusArrivalState.initial() => BusArrivalState(
        data: BusArrival.empty(),
        status: BusArrivalStatus.initial,
        failure: Failure.none(),
      );

  BusArrivalState copyWith({
    BusArrival? data,
    BusArrivalStatus? status,
    Failure? failure,
  }) {
    return BusArrivalState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  BusArrivalState({
    required this.data,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [this.data, this.status, this.failure];

  @override
  String toString() =>
      'BusArrivalState(${data.serviceNo},${data.busStopCode},${status.name})';
}
