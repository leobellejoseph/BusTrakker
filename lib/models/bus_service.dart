import 'package:flutter/material.dart';

enum BusOperator { GAS, SMRT, SBST, TTS, NA }

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
  late String serviceNo;
  late String operator;
  late int direction;
  late String category;
  late String originCode;
  late String destinationCode;
  late String amPeakFreq;
  late String amOffPeakFreq;
  late String pmPeakFreq;
  late String pmOffPeakFreq;
  late String loopDesc;
  late BusOperator busOperator;
  BusService.fromJson(Map<String, dynamic> data) {
    serviceNo = data['ServiceNo'] ?? 'NA';
    operator = data['Operator'] ?? 'NA';
    direction = data['Direction'] ?? 0;
    category = data['Category'] ?? 'NA';
    originCode = data['OriginCode'] ?? 'NA';
    destinationCode = data['DestinationCode'] ?? 'NA';
    amPeakFreq = data['AM_Peak_Freq'] ?? 'NA';
    amOffPeakFreq = data['AM_Offpeak_Freq'] ?? 'NA';
    pmPeakFreq = data['PM_Peak_Freq'] ?? 'NA';
    pmOffPeakFreq = data['PM_Offpeak_Freq'] ?? 'NA';
    loopDesc = data['LoopDesc'] ?? 'NA';
    busOperator = _getBusOperator(operator);
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

  BusOperator _getBusOperator(String operator) {
    switch (operator) {
      case 'GAS':
        return BusOperator.GAS;
      case 'SMRT':
        return BusOperator.SMRT;
      case 'SBST':
        return BusOperator.SBST;
      case 'TTS':
        return BusOperator.TTS;
      default:
        return BusOperator.NA;
    }
  }
}
