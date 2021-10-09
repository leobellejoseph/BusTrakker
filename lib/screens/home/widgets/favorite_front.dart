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
    final service = repo.getBusService(favorite.serviceNo);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              service.busOperator.color.withOpacity(0.2),
              service.busOperator.color.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 3, right: 3, top: 3),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(kBusType[arrival.type] ?? 'No Svc',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(kBusLoad[arrival.load] ?? 'No Svc',
                              style: TextStyle(color: Colors.green[700])),
                        ],
                      ),
                    ],
                  ),
            // const Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: Text(stop.description,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54)),
            )
          ],
        ),
      ),
    );
  }
}
