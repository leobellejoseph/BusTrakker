import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  String busStopCode = '';
  String serviceNo = '';
  Favorite({required this.busStopCode, required this.serviceNo});

  Map<String, dynamic> toJson() => {
        'busStopCode': busStopCode,
        'serviceNo': serviceNo,
      };
  Favorite.fromJson(Map<String, dynamic> data) {
    busStopCode = data['busStopCode'] ?? '';
    serviceNo = data['serviceNo'] ?? '';
  }
  @override
  List<Object?> get props => [this.busStopCode, this.serviceNo];
}
