import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/cubit/cubit.dart';
import 'package:my_bus/screens/screens.dart';

const kMinuteArrival = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blueAccent);
const kArriving =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.blue);
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
    2: 'Next',
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
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.lightBlue.withOpacity(0.6),
                          Colors.lightBlue.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: RawMaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            highlightColor: Colors.lightBlue,
                            onPressed: () {
                              context
                                  .read<BusRouteCubit>()
                                  .fetchRoute(service: state.data.serviceNo);
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                elevation: 2,
                                context: context,
                                builder: (context) {
                                  context.read<BusRouteCubit>().fetchRoute(
                                      service: state.data.serviceNo);
                                  return BusRouteScreen(
                                      service: state.data.serviceNo);
                                },
                              );
                            },
                            child: Center(
                              child: Text(
                                state.data.serviceNo,
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                        const Divider(color: Colors.white, height: 0),
                        Expanded(
                          child: RawMaterialButton(
                            highlightColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            onPressed: () => onFlip(),
                            child: Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _nextBus(bus: state.data.firstBus, index: 1),
              ),
              Expanded(
                child: _nextBus(bus: state.data.secondBus, index: 2),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _nextBus({required NextBus bus, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                      TextSpan(children: [
                        TextSpan(
                            text: bus.eta,
                            style: bus.eta == 'Arriving'
                                ? kArriving
                                : kMinuteArrival),
                        bus.eta == 'Arriving'
                            ? TextSpan(text: '')
                            : TextSpan(text: 'min'),
                      ]),
                    ),
                    Text(kBusLoad[bus.load] ?? 'No Svc'),
                    Text(bus.feature == 'WAB' ? 'Wheelchair' : ''),
                  ],
                ),
        ],
      ),
    );
  }
}
