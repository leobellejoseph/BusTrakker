class Failure {
  final String code;
  final String message;
  const Failure({required this.code, required this.message});
  factory Failure.none() => const Failure(code: '', message: '');
  factory Failure.arrival() => const Failure(
      code: 'Bus Arrival', message: 'Failed to fetch Bus Arrival');
  factory Failure.arrivals() => const Failure(
      code: 'Bus Arrival', message: 'Failed to fetch Bus Arrivals Services');
}
