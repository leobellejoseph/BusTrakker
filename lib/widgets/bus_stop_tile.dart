import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

class BusStopTile extends StatelessWidget {
  final BusStop item;
  final bool showDistance;
  BusStopTile({required this.item, required this.showDistance});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      child: Container(
        //margin: const EdgeInsets.all(5),
        //color: Colors.lightBlueAccent,
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.busStopCode),
            Text(item.description),
            Text(item.roadName),
            if (showDistance) Text('${item.distanceDisplay}km')
          ],
        ),
      ),
    );
  }
}
