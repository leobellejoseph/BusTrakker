import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';

const kMinuteArrival = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blueAccent);
const kArriving =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.blue);
const kBusLoad = {'SEA': 'Seats Avl.', 'SDA': 'Standing', 'LSD': 'Limited'};
const kBusFeature = {'WAB': Icons.wheelchair_pickup_outlined};
const kOperators = {
  'SBST': 'SBS',
  'SMRT': 'SMRT',
  'TTS': 'Tower Transit',
  'GAS': 'Go Ahead',
};

class BusArrivalList extends StatelessWidget {
  final Function onFlip;
  final Map<int, String> label = {
    1: 'Incoming',
    2: 'Second',
    3: 'Third',
  };
  BusArrivalList({required this.onFlip});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusArrivalCubit, BusArrivalState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: _nextBus(bus: state.data.firstBus, index: 1),
              ),
              Expanded(
                flex: 3,
                child: _nextBus(bus: state.data.secondBus, index: 2),
              ),
              Expanded(
                flex: 3,
                child: _nextBus(bus: state.data.thirdBus, index: 3),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _nextBus({required NextBus bus, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label[index] ?? 'No Svc',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black54,
                decoration: TextDecoration.underline)),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: bus.eta,
                style: bus.eta == 'Arriving' ? kArriving : kMinuteArrival),
            bus.eta == 'Arriving' ? TextSpan(text: '') : TextSpan(text: 'min'),
          ]),
        ),
        Text(kBusLoad[bus.load] ?? 'No Svc'),
        Text(bus.feature == 'WAB' ? 'Wheelchair' : ''),
        index == 1
            ? GestureDetector(
                onTap: () => onFlip(),
                child: Text('Back',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              )
            : Container(),
      ],
    );
  }
}
