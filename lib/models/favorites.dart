import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  late final String busStopCode;
  late final String serviceNo;
  late final String description;
  Favorite({
    required this.busStopCode,
    required this.serviceNo,
    required this.description,
  });
  factory Favorite.empty() =>
      Favorite(busStopCode: '', serviceNo: '', description: '');
  Map<String, dynamic> toJson() => {
        'busStopCode': busStopCode,
        'serviceNo': serviceNo,
        'description': description,
      };
  Favorite.fromJson(Map<String, dynamic> data) {
    busStopCode = data['busStopCode'] ?? '';
    serviceNo = data['serviceNo'] ?? '';
    description = data['description'] ?? '';
  }
  @override
  List<Object?> get props =>
      [this.busStopCode, this.serviceNo, this.description];
}
