part of 'bus_service_bloc.dart';

abstract class BusServiceEvent extends Equatable {
  const BusServiceEvent();
  @override
  List<Object?> get props => [];
}

class BusServiceDownload extends BusServiceEvent {}
