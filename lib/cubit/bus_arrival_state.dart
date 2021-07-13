part of 'bus_arrival_cubit.dart';

// abstract class BusArrivalState extends Equatable {
//   const BusArrivalState();
// }
enum Status { initial, loading, loaded, error, no_service }

class BusArrivalState extends Equatable {
  final List<BusArrival> data;
  final Status status;
  final Failure failure;

  factory BusArrivalState.initial() => BusArrivalState(
        data: [],
        status: Status.initial,
        failure: Failure.none(),
      );

  BusArrivalState copyWith({
    List<BusArrival>? data,
    Status? status,
    Failure? failure,
  }) {
    return BusArrivalState(
      data: data ?? this.data,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  BusArrivalState({
    required this.data,
    required this.status,
    required this.failure,
  });

  @override
  List<Object> get props => [
        this.data,
        this.status,
        this.failure,
      ];
}
