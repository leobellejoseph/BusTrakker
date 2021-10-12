import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class BusStopTile extends StatelessWidget {
  final BusStop item;
  final bool showDistance;
  BusStopTile({Key? key, required this.item, required this.showDistance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusArrivalCubit(),
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              height: kBusStopTileSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BusStopLabel(item: item),
                  const Divider(
                    color: Colors.white,
                    height: 0.4,
                  ),
                  BusStopHeader(item: item, showDistance: showDistance),
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
                        child: BusStopWidget(code: item.busStopCode),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 8,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  final availableMaps = await MapLauncher.installedMaps;
                  if (availableMaps.isNotEmpty) {
                    MapLauncher.showMarker(
                      mapType: availableMaps.first.mapType,
                      coords: Coords(item.latitude, item.longitude),
                      title: item.description,
                      description: item.busStopCode,
                    );
                  } else {
                    String googleMapUrl =
                        'https://www.google.com/maps/search/?api=1&query=${item.latitude},${item.longitude}';
                    if (await canLaunch(googleMapUrl)) {
                      await launch(googleMapUrl);
                    }
                  }
                },
                highlightColor: Colors.blue,
                child: Image.asset('images/mapicon.png', height: 40, width: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
