import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';

import 'widgets.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final FlipCardController _controller = FlipCardController();
  double showButton = 0.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return Center(child: CircularProgressIndicator());
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
                    ..getBusArrival(favorite.busStopCode, favorite.serviceNo),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: double.infinity,
                    width: 140,
                    child: BlocBuilder<BusArrivalCubit, BusArrivalState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              if (showButton > 0)
                                showButton = 0;
                              else
                                showButton = 1;
                            });
                          },
                          child: Stack(
                            children: [
                              FlipCard(
                                controller: _controller,
                                direction: FlipDirection.HORIZONTAL, // default
                                front: FavoriteFront(
                                  favorite: favorite,
                                  arrival: state.data.firstBus,
                                ),
                                back: FavoriteBack(
                                    favorite: favorite,
                                    arrival: state.data.secondBus),
                              ),
                              Transform.translate(
                                offset: const Offset(110, 85),
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: showButton,
                                  child: IconButton(
                                    icon: Icon(Icons.cancel,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .removeFavorite(
                                              code: state.data.busStopCode,
                                              service: state.data.serviceNo);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
