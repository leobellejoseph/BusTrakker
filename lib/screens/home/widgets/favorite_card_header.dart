import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/repositories.dart';

class FavoriteCardHeader extends StatelessWidget {
  final Favorite favorite;
  const FavoriteCardHeader({Key? key, required this.favorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final repo = context.read<BusRepository>();
    final BusService service = repo.getBusService(favorite.serviceNo);
    final cubit = context.read<FavoritesCubit>();
    return Container(
      padding: const EdgeInsets.all(2),
      height: 29,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                highlightColor: Colors.blue,
                onTap: () => cubit.removeFavorite(
                    favorite.busStopCode, favorite.serviceNo),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              favorite.serviceNo,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: service.busOperator.color),
            ),
            const Text(
              ' @ ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              favorite.busStopCode,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueAccent),
            )
          ],
        ),
      ),
    );
  }
}
