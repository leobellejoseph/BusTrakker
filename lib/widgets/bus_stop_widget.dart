import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/widgets/centered_text.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopWidget extends StatefulWidget {
  final String code;
  BusStopWidget({required this.code});
  @override
  _BusStopWidgetState createState() => _BusStopWidgetState();
}

class _BusStopWidgetState extends State<BusStopWidget> {
  final FlipCardController _flipCardController = FlipCardController();
  @override
  void initState() {
    super.initState();
    context.read<BusArrivalsCubit>().getBusServices(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<BusArrivalsCubit, BusArrivalsState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return LinearProgressIndicator();
        } else if (state.status == Status.no_service) {
          return CenteredText(text: 'No Service');
        } else {
          return FlipCard(
            controller: _flipCardController,
            flipOnTouch: false,
            direction: FlipDirection.VERTICAL,
            front: BusServiceList(
                state: state,
                onFlip: (value) {
                  if (value.isNotEmpty && widget.code.isNotEmpty) {
                    context
                        .read<BusArrivalCubit>()
                        .getBusArrival(widget.code, value);
                    _flipCardController.state?.toggleCard();
                  }
                }),
            back: BusArrivalList(
              onFlip: () {
                _flipCardController.state?.toggleCard();
              },
            ),
          );
        }
      },
    );
  }
}
