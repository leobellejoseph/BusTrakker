class NextBus {
  final String originCode;
  final String destinationCode;
  final String estimatedArrival;
  final String latitude;
  final String longitude;
  final String visitNumber;
  final String load;
  final String feature;
  final String type;
  final String eta;
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
    required this.eta,
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
        eta: 'NA',
      );

  factory NextBus.noSvc() => NextBus(
        originCode: 'NA',
        destinationCode: 'NA',
        estimatedArrival: '0',
        latitude: '0',
        longitude: '0',
        visitNumber: '0',
        load: 'NA',
        feature: 'NA',
        type: 'NA',
        eta: 'NoSvc',
      );

  factory NextBus.fromJson(Map<String, dynamic> data) {
    final originCode = data['OriginCode'];
    final destinationCode = data['DestinationCode'];
    final estimatedArrival = data['EstimatedArrival'] ?? '';
    final latitude = data['Latitude'];
    final longitude = data['Longitude'];
    final visitNumber = data['VisitNumber'];
    final load = data['Load'];
    final feature = data['Feature'];
    final type = data['Type'] ?? '';

    if (estimatedArrival.isEmpty) return NextBus.noSvc();

    DateTime etaDate = DateTime.parse(estimatedArrival);
    Duration difference = etaDate.difference(DateTime.now());
    final eta = difference.inMinutes <= 0
        ? 'Arriving'
        : '${difference.inMinutes.toString()}';
    return NextBus(
        originCode: originCode,
        destinationCode: destinationCode,
        estimatedArrival: estimatedArrival,
        latitude: latitude,
        longitude: longitude,
        visitNumber: visitNumber,
        load: load,
        feature: feature,
        type: type,
        eta: eta);
  }

  @override
  String toString() => 'NextBus($estimatedArrival)';
}
