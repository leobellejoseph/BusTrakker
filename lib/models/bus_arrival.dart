import 'next_bus.dart';

class BusArrival {
  final String busStopCode;
  final String serviceNo;
  final String operator;
  final NextBus firstBus;
  final NextBus secondBus;
  final NextBus thirdBus;
  static Map<String, BusArrival> _cache = {};
  BusArrival._instance({
    required this.busStopCode,
    required this.serviceNo,
    required this.operator,
    required this.firstBus,
    required this.secondBus,
    required this.thirdBus,
  });

  factory BusArrival({
    required String busStopCode,
    required String serviceNo,
    required String operator,
    required NextBus firstBus,
    required NextBus secondBus,
    required NextBus thirdBus,
  }) =>
      _cache[serviceNo + busStopCode] ??= BusArrival._instance(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
          operator: operator,
          firstBus: firstBus,
          secondBus: secondBus,
          thirdBus: thirdBus);

  factory BusArrival.noSvc() => _cache['No Svc'] ??= BusArrival._instance(
        busStopCode: 'No Svc',
        serviceNo: 'No Svc',
        operator: 'No Svc',
        firstBus: NextBus.empty(),
        secondBus: NextBus.empty(),
        thirdBus: NextBus.empty(),
      );

  factory BusArrival.empty() => _cache['NA'] ??= BusArrival._instance(
        busStopCode: 'NA',
        serviceNo: 'NA',
        operator: 'NA',
        firstBus: NextBus.empty(),
        secondBus: NextBus.empty(),
        thirdBus: NextBus.empty(),
      );

  factory BusArrival.fromJson(String stopCode, Map<String, dynamic> data) {
    final busStopCode = stopCode;
    final serviceNo = data['ServiceNo'] ?? 'NA';
    final operator = data['Operator'] ?? 'NA';
    final firstBus = data['NextBus'] == null
        ? NextBus.noSvc()
        : NextBus.fromJson(data['NextBus']);
    final secondBus = data['NextBus2'] == null
        ? NextBus.noSvc()
        : NextBus.fromJson(data['NextBus2']);
    final thirdBus = data['NextBus3'] == null
        ? NextBus.noSvc()
        : NextBus.fromJson(data['NextBus3']);
    return _cache[serviceNo + busStopCode] ??= BusArrival._instance(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        operator: operator,
        firstBus: firstBus,
        secondBus: secondBus,
        thirdBus: thirdBus);
  }

  @override
  String toString() =>
      'BusArrival($busStopCode,$serviceNo,$operator,$firstBus,$secondBus,$thirdBus)';
}
