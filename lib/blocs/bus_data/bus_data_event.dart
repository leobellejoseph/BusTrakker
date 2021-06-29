part of 'bus_data_bloc.dart';

abstract class BusDataEvent extends Equatable {
  const BusDataEvent();
}

class BusDataDownload extends BusDataEvent {
  @override
  List<Object?> get props => [];
}
