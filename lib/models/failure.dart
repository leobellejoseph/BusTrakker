class Failure {
  final String code;
  final String message;
  final StackTrace trace;
  const Failure(
      {required this.code, required this.message, required this.trace});
  factory Failure.none() =>
      const Failure(code: '', message: '', trace: StackTrace.empty);
  factory Failure.arrival([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Bus Arrival',
      message: 'Failed to fetch Bus Arrival',
      trace: trace);
  factory Failure.arrivals([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Bus Arrival',
      message: 'Failed to fetch Bus Arrivals Services',
      trace: trace);
  factory Failure.stops([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Bus Stops', message: 'Unable to download Bus Stops', trace: trace);
  factory Failure.service([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Bus Service',
      message: 'Unable to download Bus Services',
      trace: trace);
  factory Failure.route([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Bus Route',
      message: 'Unable to fetch All Bus Route',
      trace: trace);
  factory Failure.favorite([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Favorites', message: 'Unable to fetch Favorites.', trace: trace);
  factory Failure.addFavorite([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Favorites', message: 'Unable to Add Favorite.', trace: trace);
  factory Failure.removeFavorite([StackTrace trace = StackTrace.empty]) =>
      Failure(
          code: 'Favorites',
          message: 'Unable to Remove Favorites.',
          trace: trace);
  factory Failure.nearBus([StackTrace trace = StackTrace.empty]) => Failure(
      code: 'Near Bus', message: 'Failed to fetch Near Bus', trace: trace);
}
