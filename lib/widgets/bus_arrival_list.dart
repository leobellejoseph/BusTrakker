import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';

class BusArrivalList extends StatelessWidget {
  final Function onFlip;
  final String code;
  final String service;
  BusArrivalList(
      {required this.onFlip, required this.code, required this.service});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusArrivalCubit, BusArrivalState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                child: _nextBus(state.data.firstBus),
              ),
              Expanded(
                child: _nextBus(state.data.secondBus),
              ),
              Expanded(
                child: _nextBus(state.data.thirdBus),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _nextBus(NextBus bus) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(bus.estimatedArrival),
        Text(bus.load),
        Text(bus.feature),
      ],
    );
  }
}
