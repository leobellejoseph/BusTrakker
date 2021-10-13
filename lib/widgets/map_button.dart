import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MapButton extends StatelessWidget {
  final BusStop stop;
  final Widget child;
  const MapButton({
    Key? key,
    required this.stop,
    required this.child,
  }) : super(key: key);

  factory MapButton.lottie(BusStop busStop, String json) =>
      MapButton(stop: busStop, child: LottieWidget(asset: json));

  @override
  Widget build(BuildContext context) {
    return InkWellButton(
      borderRadius: BorderRadius.circular(2),
      highlightColor: Colors.lightBlueAccent.withOpacity(0.5),
      border: RoundedRectangleBorder(),
      onPress: () async {
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
      widget: child,
    );
  }
}
