import 'package:flutter/material.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/bus_repository.dart';

class FavoriteFront extends StatelessWidget {
  final Favorite favorite;
  final NextBus arrival;
  final BusRepository repo;
  FavoriteFront(
      {required this.favorite, required this.arrival, required this.repo});
  @override
  Widget build(BuildContext context) {
    final stop = repo.getBusStop(favorite.busStopCode);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent.withOpacity(0.2),
              Colors.lightBlueAccent.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            arrival.eta == 'NA'
                ? Text('No Svc', style: kArriving)
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: arrival.eta,
                                style: arrival.eta == 'Arriving'
                                    ? kArriving
                                    : kMinuteArrival),
                            arrival.eta == 'Arriving'
                                ? TextSpan(text: '')
                                : int.parse(arrival.eta) == 1
                                    ? TextSpan(text: 'min')
                                    : TextSpan(text: 'mins'),
                          ],
                        ),
                      ),
                      // const Divider(
                      //   height: 0,
                      //   color: Colors.blueGrey,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(kBusType[arrival.type] ?? 'No Svc',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(kBusLoad[arrival.load] ?? 'No Svc',
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
            const Divider(height: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: Text('${stop.description}, ${stop.roadName}',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey)),
            )
          ],
        ),
      ),
    );
  }
}
