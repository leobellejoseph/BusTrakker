part of 'bus_service_bloc.dart';

enum BusServiceStatus { initial, loading, loaded, error }

class BusServiceState extends Equatable {
  final List<BusService> data;
  final BusServiceStatus status;
  const BusServiceState({required this.data, required this.status});

  factory BusServiceState.initial() =>
      BusServiceState(data: [], status: BusServiceStatus.initial);

  @override
  List<Object> get props => [this.data, this.status];
}
