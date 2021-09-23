import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String busStopCode;
  final String serviceNo;
  final String description;
  static Map<String, Favorite> _cache = {};
  Favorite._instance({
    required this.busStopCode,
    required this.serviceNo,
    required this.description,
  });

  factory Favorite({
    required String busStopCode,
    required String serviceNo,
    required String description,
  }) =>
      _cache[serviceNo + busStopCode] ??= Favorite._instance(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        description: description,
      );

  factory Favorite.empty() => Favorite._instance(
        busStopCode: '',
        serviceNo: '',
        description: '',
      );
  Map<String, dynamic> toJson() => {
        'busStopCode': busStopCode,
        'serviceNo': serviceNo,
        'description': description,
      };
  factory Favorite.fromJson(Map<String, dynamic> data) {
    final busStopCode = data['busStopCode'] ?? '';
    final serviceNo = data['serviceNo'] ?? '';
    final description = data['description'] ?? '';
    return Favorite._instance(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        description: description);
  }
  @override
  List<Object?> get props =>
      [this.busStopCode, this.serviceNo, this.description];
}
