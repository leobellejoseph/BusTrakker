import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/repositories.dart';
import 'package:my_bus/widgets/widgets.dart';

class FavoriteCardHeader extends StatelessWidget {
  final Favorite favorite;
  const FavoriteCardHeader({Key? key, required this.favorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = context.read<BusRepository>();
    final BusService service = repo.getBusService(favorite.serviceNo);
    final cubit = context.read<FavoritesCubit>();
    final stop = repo.getBusStop(favorite.busStopCode);
    return Container(
      padding: const EdgeInsets.all(2),
      height: 28,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWellButton(
              onPress: () => cubit.removeFavorite(
                  favorite.busStopCode, favorite.serviceNo),
              widget: Icon(
                Icons.star,
                color: Colors.yellow.shade700,
              ),
            ),
            Text(
              favorite.serviceNo,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: service.busOperator.color),
            ),
            const Text(
              '@',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            MapButton(
              stop: stop,
              child: Text(
                favorite.busStopCode,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
