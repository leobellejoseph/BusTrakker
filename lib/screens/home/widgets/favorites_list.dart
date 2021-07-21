import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/widgets/centered_spinner.dart';

import 'widgets.dart';

class FavoritesList extends StatelessWidget {
  final FlipCardController _controller = FlipCardController();

  void _refreshArrival(BuildContext context, BusArrivalState state) => context
      .read<BusArrivalCubit>()
      .getBusArrival(state.data.busStopCode, state.data.serviceNo, true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return CenteredSpinner();
        } else {
          return Container(
            height: 125,
            child: ListView.builder(
              itemCount: state.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final favorite = state.data[index];
                return BlocProvider<BusArrivalCubit>(
                  create: (context) => BusArrivalCubit()
                    ..getBusArrival(
                        favorite.busStopCode, favorite.serviceNo, true),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: double.infinity,
                    width: 140,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            height: 25,
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: favorite.serviceNo,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const TextSpan(
                                      text: ' @ ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    TextSpan(
                                      text: favorite.busStopCode,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.blue[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //const Divider(),
                          Expanded(
                            child:
                                BlocBuilder<BusArrivalCubit, BusArrivalState>(
                              builder: (context, state) {
                                if (state.status == BusArrivalStatus.loading) {
                                  return CenteredSpinner();
                                } else {
                                  return GestureDetector(
                                    onLongPress: () {
                                      if (_controller.state?.isFront == true) {
                                        _refreshArrival(context, state);
                                      } else
                                        _controller.toggleCard();
                                    },
                                    child: FlipCard(
                                      onFlipDone: (event) {
                                        if (event)
                                          _refreshArrival(context, state);
                                      },
                                      controller: _controller,
                                      direction: FlipDirection.HORIZONTAL,
                                      front: FavoriteFront(
                                        favorite: favorite,
                                        arrival: state.data.firstBus,
                                      ),
                                      back: FavoriteBack(
                                          favorite: favorite,
                                          arrival: state.data.secondBus),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
