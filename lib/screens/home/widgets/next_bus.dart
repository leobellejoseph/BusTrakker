import 'package:flutter/material.dart';
import 'package:my_bus/constants/constants.dart';
import 'package:my_bus/models/models.dart';

class NextBusWidget extends StatelessWidget {
  final NextBus bus;
  final int index;
  NextBusWidget({Key? key, required this.bus, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label[index] ?? 'No Svc',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                  decoration: TextDecoration.underline)),
          bus.eta == 'NA'
              ? Text('No Svc', style: kArriving)
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: bus.eta,
                              style: bus.eta == 'Arriving'
                                  ? kArriving
                                  : kMinuteArrival),
                          bus.eta == 'Arriving'
                              ? TextSpan(text: '')
                              : int.parse(bus.eta) == 1
                                  ? TextSpan(text: 'min')
                                  : TextSpan(text: 'mins'),
                        ],
                      ),
                    ),
                    Text(
                      kBusType[bus.type] ?? 'No Svc',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent.shade700),
                    ),
                    Text(
                      kBusLoad[bus.load] ?? 'No Svc',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black54),
                    ),
                    Text(
                      bus.feature == 'WAB' ? '♿️' : '',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
