import 'package:flutter/material.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/models/models.dart';

class FavoriteBack extends StatelessWidget {
  final Favorite favorite;
  final NextBus arrival;
  FavoriteBack({required this.favorite, required this.arrival});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                              : int.parse(arrival.eta) == 1
                                  ? TextSpan(text: 'min')
                                  : TextSpan(text: 'mins'),
                          //: TextSpan(text: 'min'),
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
                    // Text(kBusType[arrival.type] ?? 'No Svc'),
                    // Text(kBusLoad[arrival.load] ?? 'No Svc'),
                    // Text(arrival.feature == 'WAB' ? 'Wheelchair' : ''),
                  ],
                ),
        ],
      ),
    );
  }
}
