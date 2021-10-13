import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:my_bus/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets.dart';

class AnimatedMapButton extends HookWidget {
  final BusStop stop;
  const AnimatedMapButton({Key? key, required this.stop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController();
    return InkWellButton(
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
      widget: Lottie.asset(
        'assets/mapmarker.json',
        height: 50,
        width: 50,
        repeat: true,
        controller: controller,
        onLoaded: (composition) {
          // Configure the AnimationController with the duration of the
          // Lottie file and start the animation.
          controller
            ..duration = composition.duration
            ..repeat();
        },
      ),
    );
  }
}
