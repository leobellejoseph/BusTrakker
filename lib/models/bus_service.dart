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
  }
}
