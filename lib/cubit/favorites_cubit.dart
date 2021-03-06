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
      if (data.isEmpty) {
        emit(state.copyWith(data: [], status: FavoriteStatus.no_data));
      } else {
        emit(state.copyWith(data: data, status: FavoriteStatus.loaded));
      }
    } on Failure catch (_) {
      emit(
        state.copyWith(
            status: FavoriteStatus.error, failure: Failure.favorite()),
      );
    }
  }

  void addFavorite(
      {required String code,
      required String service,
      String description = ''}) {
    emit(state.copyWith(status: FavoriteStatus.loading, index: 0));
    try {
      final stop = _busRepository.getBusStop(code);
      final favorite = Favorite(
        busStopCode: code,
        serviceNo: service,
        description: stop.description,
      );
      final data = _busRepository.addFavorite(favorite: favorite);
      emit(state.copyWith(data: data, status: FavoriteStatus.loaded, index: 0));
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          failure: Failure.addFavorite(),
        ),
      );
    }
  }

  void removeFavorite(String code, String service) {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final list = state.data;
      final favorite = list.firstWhere(
          (item) => item.busStopCode == code && item.serviceNo == service);
      _busRepository.removeFavorite(favorite: favorite);
      list.remove(favorite);
      if (list.isEmpty) {
        emit(state.copyWith(data: [], status: FavoriteStatus.no_data));
      } else {
        emit(state.copyWith(data: list, status: FavoriteStatus.loaded));
      }
    } on Failure catch (_) {
      emit(
        state.copyWith(
          status: FavoriteStatus.error,
          failure: Failure.removeFavorite(),
        ),
      );
    }
  }

  void removeAll() {
    try {
      emit(state.copyWith(status: FavoriteStatus.loading));
      _busRepository.removeAllFavorites();
      emit(state.copyWith(data: [], status: FavoriteStatus.no_data));
    } on Failure catch (_) {
      emit(state.copyWith(
          failure:
              Failure(code: 'Remove All', message: 'Unable to remove data')));
    }
  }

  bool isFavorite({required String code, required String service}) =>
      _busRepository.isFavorite(service: service, code: code);
}
