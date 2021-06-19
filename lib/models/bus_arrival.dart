import 'next_bus.dart';

class BusArrival {
  String busStopCode = 'NA';
  String serviceNo = 'NA';
  String operator = 'NA';
  NextBus firstBus = NextBus.empty();
  NextBus secondBus = NextBus.empty();
  NextBus thirdBus = NextBus.empty();
  BusArrival({
    required this.busStopCode,
    required this.serviceNo,
    required this.operator,
    required this.firstBus,
    required this.secondBus,
    required this.thirdBus,
  });

  factory BusArrival.empty() => BusArrival(
        busStopCode: 'NA',
        serviceNo: 'NA',
        operator: 'NA',
        firstBus: NextBus.empty(),
        secondBus: NextBus.empty(),
        thirdBus: NextBus.empty(),
      );

  BusArrival.fromJson(String stopCode, Map<String, dynamic> data) {
    busStopCode = stopCode;
    serviceNo = data['ServiceNo'] ?? 'NA';
    operator = data['Operator'] ?? 'NA';
    firstBus = NextBus.fromJson(data['NextBus']);
    secondBus = NextBus.fromJson(data['NextBus2']);
    thirdBus = NextBus.fromJson(data['NextBus3']);
  }
}
