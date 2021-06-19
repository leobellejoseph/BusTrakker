class BusRoute {
  String serviceNo = 'NA';
  String operator = 'NA';
  int direction = 0;
  int stopSequence = 0;
  String busStopCode = 'NA';
  String distance = 'NA';

  BusRoute({
    required this.serviceNo,
    required this.operator,
    required this.direction,
    required this.stopSequence,
    required this.busStopCode,
    required this.distance,
  });

  BusRoute.fromJson(Map<String, dynamic> data) {
    serviceNo = data['ServiceNo'];
    operator = data['Operator'];
    direction = data['Direction'];
    stopSequence = data['StopSequence'];
    busStopCode = data['BusStopCode'];
    distance = data['Distance'].toString();
  }
}
