part of 'bus_data_bloc.dart';

enum BusDataStatus {
  initial,
  busServiceLoading,
  busStopsLoading,
  busServiceLoaded,
  busStopsLoaded,
  allLoaded,
  error,
}

class BusDataState extends Equatable {
  final List<BusStop> stopsData;
  final List<BusService> serviceData;
  final BusDataStatus status;
  final Failure failure;

  factory BusDataState.initial() => BusDataState(
        stopsData: [],
        serviceData: [],
        status: BusDataStatus.initial,
        failure: Failure.none(),
      );

  BusDataState copyWith({
    List<BusStop>? stopsData,
    List<BusService>? serviceData,
    BusDataStatus? status,
    Failure? failure,
  }) {
    return BusDataState(
      stopsData: stopsData ?? this.stopsData,
      serviceData: serviceData ?? this.serviceData,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  const BusDataState({
    required this.stopsData,
    required this.serviceData,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [
        this.stopsData,
        this.serviceData,
        this.status,
        this.failure,
      ];
}
