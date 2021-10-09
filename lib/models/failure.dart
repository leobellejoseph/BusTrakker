class Failure {
  final String code;
  final String message;
  const Failure({required this.code, required this.message});
  factory Failure.none() => const Failure(code: '', message: '');
  factory Failure.arrival() => const Failure(
      code: 'Bus Arrival', message: 'Failed to fetch Bus Arrival');
  factory Failure.arrivals() => const Failure(
      code: 'Bus Arrival', message: 'Failed to fetch Bus Arrivals Services');
  factory Failure.stops() =>
      const Failure(code: 'Bus Stops', message: 'Unable to download Bus Stops');
  factory Failure.service([StackTrace trace = StackTrace.empty]) =>
      const Failure(
          code: 'Bus Service', message: 'Unable to download Bus Services');
  factory Failure.route() => const Failure(
      code: 'Bus Route', message: 'Unable to fetch All Bus Route');
  factory Failure.favorite() =>
      const Failure(code: 'Favorites', message: 'Unable to fetch Favorites.');
  factory Failure.addFavorite() =>
      const Failure(code: 'Favorites', message: 'Unable to Add Favorite.');
  factory Failure.removeFavorite() =>
      const Failure(code: 'Favorites', message: 'Unable to Remove Favorites.');
  factory Failure.nearBus() =>
      const Failure(code: 'Near Bus', message: 'Failed to fetch Near Bus');
}
