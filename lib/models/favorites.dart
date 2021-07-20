import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String busStopCode;
  final String serviceNo;
  Favorite({required this.busStopCode, required this.serviceNo});

  @override
  List<Object?> get props => [this.busStopCode, this.serviceNo];
}
