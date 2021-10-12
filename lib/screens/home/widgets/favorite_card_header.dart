import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/repositories.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Material(
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                highlightColor: Colors.grey,
                onTap: () async {
                  final availableMaps = await MapLauncher.installedMaps;
                  if (availableMaps.isNotEmpty) {
                    MapLauncher.showMarker(
                      mapType: availableMaps.first.mapType,
                      coords: Coords(stop.latitude, stop.longitude),
                      title: stop.description,
                      description: stop.busStopCode,
                    );
                  } else {
                    String googleMapUrl =
                        'https://www.google.com/maps/search/?api=1&query=${stop.latitude},${stop.longitude}';
                    if (await canLaunch(googleMapUrl)) {
                      await launch(googleMapUrl);
                    }
                  }
                },
                child: Text(
                  favorite.busStopCode,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
