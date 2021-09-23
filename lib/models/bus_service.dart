import 'package:flutter/material.dart';

enum BusOperator { GAS, SMRT, SBST, TTS, NA }

const BusOperatorMap = {
  'GAS': BusOperator.GAS,
  'SMRT': BusOperator.SMRT,
  'SBST': BusOperator.SBST,
  'TTS': BusOperator.TTS,
  'NA': BusOperator.NA,
};

extension BusOperatorExtension on BusOperator {
  String get name {
    switch (this) {
      case BusOperator.GAS:
        return 'Go Ahead';
      case BusOperator.SMRT:
        return 'SMRT';
      case BusOperator.SBST:
        return 'SBS Transport';
      case BusOperator.TTS:
        return 'Tower Transit';
      default:
        return 'NA';
    }
  }

  Color get color {
    switch (this) {
      case BusOperator.GAS:
        return Colors.yellow.shade800;
      case BusOperator.SMRT:
        return Colors.red.shade800;
      case BusOperator.SBST:
        return Colors.deepPurple.shade600;
      case BusOperator.TTS:
        return Colors.green.shade800;
      default:
        return Colors.white;
    }
  }

  Color get textColor => Colors.white;
}

class BusService {
  final String serviceNo;
  final String operator;
  final int direction;
  final String category;
  final String originCode;
  final String destinationCode;
  final String amPeakFreq;
  final String amOffPeakFreq;
  final String pmPeakFreq;
  final String pmOffPeakFreq;
  final String loopDesc;
  final BusOperator busOperator;

  static Map<String, BusService> _cache = {};

  const BusService._instance({
    required this.serviceNo,
    required this.operator,
    required this.direction,
    required this.category,
    required this.originCode,
    required this.destinationCode,
    required this.amPeakFreq,
    required this.amOffPeakFreq,
    required this.pmPeakFreq,
    required this.pmOffPeakFreq,
    required this.loopDesc,
    required this.busOperator,
  });

  factory BusService({
    required String service,
    required String operator,
    required int direction,
    required String category,
    required String originCode,
    required String destinationCode,
    required String amPeakFreq,
    required String amOffPeakFreq,
    required String pmPeakFreq,
    required String pmOffPeakFreq,
    required String loopDesc,
    required BusOperator busOperator,
  }) =>
      _cache[service] ??= BusService._instance(
        serviceNo: service,
        operator: operator,
        direction: direction,
        category: category,
        originCode: originCode,
        destinationCode: destinationCode,
        amPeakFreq: amPeakFreq,
        amOffPeakFreq: amOffPeakFreq,
        pmPeakFreq: pmPeakFreq,
        pmOffPeakFreq: pmOffPeakFreq,
        loopDesc: loopDesc,
        busOperator: busOperator,
      );

  factory BusService.empty() => BusService(
        service: '',
        operator: '',
        direction: 0,
        category: '',
        originCode: '',
        destinationCode: '',
        amPeakFreq: '',
        amOffPeakFreq: '',
        pmPeakFreq: '',
        pmOffPeakFreq: '',
        loopDesc: '',
        busOperator: BusOperator.NA,
      );

  factory BusService.fromJson(Map<String, dynamic> data) {
    final service = data['ServiceNo'];
    final operator = data['Operator'];
    final direction = data['Direction'];
    final category = data['Category'];
    final originCode = data['OriginCode'];
    final destinationCode = data['DestinationCode'];
    final amPeakFreq = data['AM_Peak_Freq'];
    final amOffPeakFreq = data['AM_Offpeak_Freq'];
    final pmPeakFreq = data['PM_Peak_Freq'];
    final pmOffPeakFreq = data['PM_Offpeak_Freq'];
    final loopDesc = data['LoopDesc'];
    final busOperator = BusOperatorMap[operator] ?? BusOperator.NA;
    return _cache[service] ??= BusService._instance(
        serviceNo: service,
        operator: operator,
        direction: direction,
        category: category,
        originCode: originCode,
        destinationCode: destinationCode,
        amPeakFreq: amPeakFreq,
        amOffPeakFreq: amOffPeakFreq,
        pmPeakFreq: pmPeakFreq,
        pmOffPeakFreq: pmOffPeakFreq,
        loopDesc: loopDesc,
        busOperator: busOperator);
  }

  Map<String, dynamic> toJson() => {
        'ServiceNo': serviceNo,
        'Operator': operator,
        'Direction': direction,
        'Category': category,
        'OriginCode': originCode,
        'DestinationCode': destinationCode,
        'AM_Peak_Freq': amPeakFreq,
        'AM_Offpeak_Freq': amOffPeakFreq,
        'PM_Peak_Freq': pmPeakFreq,
        'PM_Offpeak_Freq': pmOffPeakFreq,
        'LoopDesc': loopDesc
      };
}
