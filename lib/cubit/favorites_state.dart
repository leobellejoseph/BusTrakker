part of 'favorites_cubit.dart';

enum FavoriteStatus { initial, loaded, loading, error, no_data }

class FavoritesState extends Equatable {
  final List<Favorite> data;
  final FavoriteStatus status;
  final Failure failure;
  final int index;
  FavoritesState copyWith({
    List<Favorite>? data,
    FavoriteStatus? status,
    Failure? failure,
    int? index,
  }) {
    return FavoritesState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      index: index ?? this.index,
    );
  }

  FavoritesState({
    required this.data,
    required this.status,
    required this.failure,
    required this.index,
  });

  factory FavoritesState.initial() => FavoritesState(
        data: [],
        status: FavoriteStatus.initial,
        failure: Failure.none(),
        index: 0,
      );

  @override
  List<Object> get props => [this.data, this.status, this.failure, this.index];
}
