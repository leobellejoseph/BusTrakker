part of 'bus_data_bloc.dart';

abstract class BusDataEvent extends Equatable {
  const BusDataEvent();
}

class BusDataDownload extends BusDataEvent {
  @override
  List<Object?> get props => [];
}

class BusStopFetch extends BusDataEvent {
  final String query;
  BusStopFetch(this.query);
  @override
  List<Object?> get props => [this.query];
}

class BusServiceFetch extends BusDataEvent {
  final String query;
  BusServiceFetch(this.query);
  @override
  List<Object?> get props => [this.query];
}

class NearBusStopsFetch extends BusDataEvent {
  final String query;
  NearBusStopsFetch(this.query);
  @override
  List<Object?> get props => [this.query];
}
