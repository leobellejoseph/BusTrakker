class NextBus {
  String originCode = 'NA';
  String destinationCode = 'NA';
  String estimatedArrival = '0';
  String latitude = '0';
  String longitude = '0';
  String visitNumber = '0';
  String load = 'NA';
  String feature = 'NA';
  String type = 'NA';
  String eta = 'NA';

  NextBus({
    required this.originCode,
    required this.destinationCode,
    required this.estimatedArrival,
    required this.latitude,
    required this.longitude,
    required this.visitNumber,
    required this.load,
    required this.feature,
    required this.type,
  });

  factory NextBus.empty() => NextBus(
        originCode: 'NA',
        destinationCode: 'NA',
        estimatedArrival: '0',
        latitude: '0',
        longitude: '0',
        visitNumber: '0',
        load: 'NA',
        feature: 'NA',
        type: 'NA',
      );

  NextBus.fromJson(Map<String, dynamic> data) {
    originCode = data['OriginCode'];
    destinationCode = data['DestinationCode'];
    estimatedArrival = data['EstimatedArrival'] ?? '';
    latitude = data['Latitude'];
    longitude = data['Longitude'];
    visitNumber = data['VisitNumber'];
    load = data['Load'];
    feature = data['Feature'];
    type = data['Type'] ?? '';
    if (estimatedArrival.isEmpty) return;
    DateTime etaDate = DateTime.parse(estimatedArrival);
    Duration difference = etaDate.difference(DateTime.now());
    if (difference.inMinutes <= 0) {
      eta = 'Arriving';
    } else {
      eta = '${difference.inMinutes.toString()}';
    }
  }

  @override
  String toString() => 'NextBus($estimatedArrival)';
}
