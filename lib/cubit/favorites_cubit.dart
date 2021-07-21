import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final BusRepository _busRepository;
  FavoritesCubit({required BusRepository busRepository})
      : _busRepository = busRepository,
        super(FavoritesState.initial());

  void fetch() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final data = await _busRepository.fetchFavorites();
      emit(state.copyWith(data: data, status: FavoriteStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          failure:
              Failure(code: 'Favorites', message: 'Unable to fetch Favorites.'),
        ),
      );
    }
  }

  void addFavorite({required String code, required String service}) {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final favorite = Favorite(busStopCode: code, serviceNo: service);
      final data = _busRepository.addFavorite(favorite: favorite);
      emit(state.copyWith(data: data, status: FavoriteStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          failure:
              Failure(code: 'Favorites', message: 'Unable to Add Favorite.'),
        ),
      );
    }
  }

  void removeFavorite({required String code, required String service}) {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final favorite = Favorite(busStopCode: code, serviceNo: service);
      final list = state.data;
      list.remove(favorite);
      emit(state.copyWith(data: list, status: FavoriteStatus.loaded));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          failure: Failure(
              code: 'Favorites', message: 'Unable to Remove Favorites.'),
        ),
      );
    }
  }

  bool isFavorite({required String code, required String service}) =>
      _busRepository.isFavorite(service: service, code: code);
}
