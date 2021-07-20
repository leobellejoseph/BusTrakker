import 'package:flutter/material.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/models/models.dart';

class FavoriteBack extends StatelessWidget {
  final Favorite favorite;
  final NextBus arrival;
  FavoriteBack({required this.favorite, required this.arrival});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            height: 25,
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: favorite.serviceNo,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const TextSpan(
                      text: ' @ ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: favorite.busStopCode,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent.withOpacity(0.2),
                    Colors.blueAccent.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Next', style: TextStyle(fontWeight: FontWeight.w600)),
                  const Divider(height: 0),
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
                                      : TextSpan(text: 'min'),
                                ],
                              ),
                            ),
                            Text(kBusLoad[arrival.load] ?? 'No Svc'),
                            Text(arrival.feature == 'WAB' ? 'Wheelchair' : ''),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
