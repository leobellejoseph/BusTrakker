import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class BusStopTile extends StatefulWidget {
  final BusStop item;
  final bool showDistance;
  BusStopTile({Key? key, required this.item, required this.showDistance})
      : super(key: key);

  @override
  State<BusStopTile> createState() => _BusStopTileState();
}

class _BusStopTileState extends State<BusStopTile>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusArrivalCubit(),
      child: SizedBox.fromSize(
        size: const Size(double.infinity, 190),
        child: Stack(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BusStopLabel(item: widget.item),
                  const Divider(
                    color: Colors.white,
                    height: 0.4,
                  ),
                  BusStopHeader(
                      item: widget.item, showDistance: widget.showDistance),
                  const Divider(
                    color: Colors.white,
                    height: 0.4,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF1b7b90).withOpacity(0.6),
                            Color(0xFF1b7b90).withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: BusStopWidget(code: widget.item.busStopCode),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                child: InkWell(
                  //borderRadius: BorderRadius.circular(20),
                  customBorder: CircleBorder(),
                  onTap: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    if (availableMaps.isNotEmpty) {
                      MapLauncher.showMarker(
                        mapType: availableMaps.first.mapType,
                        coords:
                            Coords(widget.item.latitude, widget.item.longitude),
                        title: widget.item.description,
                        description: widget.item.busStopCode,
                      );
                    } else {
                      String googleMapUrl =
                          'https://www.google.com/maps/search/?api=1&query=${widget.item.latitude},${widget.item.longitude}';
                      if (await canLaunch(googleMapUrl)) {
                        await launch(googleMapUrl);
                      }
                    }
                  },
                  highlightColor: Colors.lightBlueAccent,
                  child: Lottie.asset(
                    'assets/mapmarker.json',
                    height: 50,
                    width: 50,
                    repeat: true,
                    controller: _controller,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      _controller
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                  // Image.asset('images/mapicon.png', height: 40, width: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
