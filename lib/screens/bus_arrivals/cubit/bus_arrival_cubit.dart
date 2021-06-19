import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bus_arrival_state.dart';

class BusArrivalCubit extends Cubit<BusArrivalState> {
  BusArrivalCubit() : super(BusArrivalInitial());
}
