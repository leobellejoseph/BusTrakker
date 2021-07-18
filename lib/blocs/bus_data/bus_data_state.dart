part of 'bus_data_bloc.dart';

enum BusDataStatus {
  initial,
  nearBusStopsLoading,
  busServiceLoading,
  busServiceLoaded,
  busStopsLoading,
  busStopsLoaded,
  nearBusStopsLoaded,
  allLoaded,
  error,
}

class BusDataState extends Equatable {
  final List<BusStop> stopsData;
  final List<BusService> serviceData;
  final List<BusStop> nearData;
  final BusDataStatus status;
  final Failure failure;

  factory BusDataState.initial() => BusDataState(
        stopsData: [],
        serviceData: [],
        nearData: [],
        status: BusDataStatus.initial,
        failure: Failure.none(),
      );

  BusDataState copyWith({
    List<BusStop>? stopsData,
    List<BusService>? serviceData,
    List<BusStop>? nearData,
    BusDataStatus? status,
    Failure? failure,
  }) {
    return BusDataState(
      stopsData: stopsData ?? this.stopsData,
      serviceData: serviceData ?? this.serviceData,
      nearData: nearData ?? this.nearData,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  const BusDataState({
    required this.stopsData,
    required this.serviceData,
    required this.nearData,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [
        this.stopsData,
        this.serviceData,
        this.nearData,
        this.status,
        this.failure,
      ];
}
