part of 'near_bus_cubit.dart';

enum NearBusStatus {
  initial,
  loaded,
  loading,
  error,
  no_location,
  no_permission,
  no_data,
}

class NearBusState extends Equatable {
  final List<BusStop> data;
  final NearBusStatus status;
  final Failure failure;

  NearBusState copyWith({
    List<BusStop>? data,
    NearBusStatus? status,
    Failure? failure,
  }) {
    return NearBusState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  NearBusState(
      {required this.data, required this.status, required this.failure});
  factory NearBusState.initial() => NearBusState(
      data: [], status: NearBusStatus.initial, failure: Failure.none());
  @override
  // TODO: implement props
  List<Object?> get props => [this.data, this.status, this.failure];
}
