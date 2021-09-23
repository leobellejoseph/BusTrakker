class BusRoute {
  final String serviceNo;
  final String operator;
  final int direction;
  final int stopSequence;
  final String busStopCode;
  final String distance;
  static Map<String, BusRoute> _cache = {};
  const BusRoute._instance({
    required this.serviceNo,
    required this.operator,
    required this.direction,
    required this.stopSequence,
    required this.busStopCode,
    required this.distance,
  });

  factory BusRoute({
    required String serviceNo,
    required String operator,
    required int direction,
    required int stopSequence,
    required String busStopCode,
    required String distance,
  }) =>
      _cache[serviceNo + busStopCode] ??= BusRoute._instance(
          serviceNo: serviceNo,
          operator: operator,
          direction: direction,
          stopSequence: stopSequence,
          busStopCode: busStopCode,
          distance: distance);

  factory BusRoute.fromJson(Map<String, dynamic> data) {
    final serviceNo = data['ServiceNo'];
    final busStopCode = data['BusStopCode'];
    final operator = data['Operator'];
    final direction = data['Direction'];
    final stopSequence = data['StopSequence'];
    final distance = data['Distance'].toString();
    return _cache[serviceNo + busStopCode] ??= BusRoute._instance(
        serviceNo: serviceNo,
        operator: operator,
        direction: direction,
        stopSequence: stopSequence,
        busStopCode: busStopCode,
        distance: distance);
  }

  Map<String, dynamic> toJson() => {
        'ServiceNo': serviceNo,
        'Operator': operator,
        'Direction': direction,
        'StopSequence': stopSequence,
        'BusStopCode': busStopCode,
        'Distance': distance,
      };
}
