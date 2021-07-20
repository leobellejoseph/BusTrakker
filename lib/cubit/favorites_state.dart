part of 'favorites_cubit.dart';

enum FavoriteStatus { initial, loaded, loading, error }

class FavoritesState extends Equatable {
  final List<Favorite> data;
  final FavoriteStatus status;
  final Failure failure;
  FavoritesState copyWith({
    List<Favorite>? data,
    FavoriteStatus? status,
    Failure? failure,
  }) {
    return FavoritesState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  FavoritesState({
    required this.data,
    required this.status,
    required this.failure,
  });

  factory FavoritesState.initial() => FavoritesState(
        data: [],
        status: FavoriteStatus.initial,
        failure: Failure.none(),
      );

  @override
  List<Object> get props => [this.data, this.status, this.failure];
}
