import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

import 'widgets.dart';

class FavoritesList extends StatelessWidget {
  final List<Favorite> _favorites = [
    Favorite(
        serviceNo: '101', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '102', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '103', busStopCode: '123456', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '104', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '105', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '106', busStopCode: '123456', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '107', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '108', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '109', busStopCode: '123456', arrival: BusArrival.empty()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        itemCount: _favorites.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final favorite = _favorites[index];
          return Container(
            margin: const EdgeInsets.all(2),
            height: double.infinity,
            width: 150,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: FavoriteFront(favorite: favorite),
              back: FavoriteBack(favorite: favorite),
            ),
          );
        },
      ),
    );
  }
}
