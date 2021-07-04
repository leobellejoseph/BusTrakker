import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bus_route_state.dart';

class BusRouteCubit extends Cubit<BusRouteState> {
  BusRouteCubit() : super(BusRouteInitial());
}
