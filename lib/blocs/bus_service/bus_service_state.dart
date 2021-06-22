part of 'bus_service_bloc.dart';

enum BusServiceStatus { initial, loading, loaded, error }

class BusServiceState extends Equatable {
  final List<BusService> data;
  final BusServiceStatus status;

  BusServiceState copyWith({
    List<BusService>? data,
    BusServiceStatus? status,
    Failure? failure,
  }) {
    return BusServiceState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  final Failure failure;
  BusServiceState({
    required this.data,
    required this.status,
    required this.failure,
  });

  factory BusServiceState.initial() => BusServiceState(
        data: [],
        status: BusServiceStatus.initial,
        failure: Failure.none(),
      );

  @override
  List<Object> get props => [this.data, this.status, this.failure];
}
