import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class FavoriteCardContent extends StatelessWidget {
  final Favorite favorite;
  const FavoriteCardContent({Key? key, required this.favorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          FavoriteCardHeader(key: ValueKey('header'), favorite: favorite),
          Expanded(
            child: FavoriteArrivalCard(fave: favorite),
          ),
        ],
      ),
    );
  }
}
