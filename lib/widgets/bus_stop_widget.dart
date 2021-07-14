import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/bus_arrival_cubit.dart';

class BusStopWidget extends StatelessWidget {
  final String code;
  final String roadName;
  final String description;
  final String distance;
  final bool showServices;
  final FlipCardController _flipCardController = FlipCardController();
  BusStopWidget({
    required this.code,
    required this.roadName,
    required this.description,
    required this.distance,
    required this.showServices,
  });
  String _showDescription() {
    return description;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<BusArrivalCubit>(context).getBusServices(code);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF1b7b90),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                code,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    distance.isNotEmpty
                        ? TextSpan(
                            text: '$distance @ ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          )
                        : TextSpan(),
                    TextSpan(
                      text: roadName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white,
          height: 0.4,
        ),
        Container(
          height: 25,
          color: Color(0xFF79ab8c),
          child: Center(
              child: Text(
            description,
            style: TextStyle(
                color: Color(0xFF1b7b90),
                fontWeight: FontWeight.w600,
                fontSize: 14),
          )),
        ),
        const Divider(
          color: Colors.white,
          height: 0.5,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1b7b90).withOpacity(0.6),
                  Color(0xFF1b7b90).withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.5),
              child: BlocBuilder<BusArrivalCubit, BusArrivalState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.status == Status.no_service) {
                    return Center(child: Text('No Service'));
                  } else {
                    return FlipCard(
                      controller: _flipCardController,
                      flipOnTouch: false,
                      direction: FlipDirection.VERTICAL,
                      front: BusServiceList(
                          state: state,
                          onFlip: (value) {
                            print(value);
                            _flipCardController.state?.toggleCard();
                          }),
                      back: BusArrivalList(
                          state: state,
                          onFlip: (value) =>
                              _flipCardController.state?.toggleCard()),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BusServiceList extends StatelessWidget {
  final BusArrivalState state;
  final Function onFlip;
  BusServiceList({required this.state, required this.onFlip});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1, crossAxisSpacing: 1, crossAxisCount: 2),
      itemBuilder: (context, index) {
        final item = state.data[index];
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF008b8b),
            borderRadius: BorderRadius.circular(2),
          ),
          child: RawMaterialButton(
            highlightColor: Colors.lightBlueAccent,
            onPressed: () => onFlip(item.serviceNo),
            child: Center(
              child: Text(
                item.serviceNo,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BusArrivalList extends StatelessWidget {
  final BusArrivalState state;
  final Function onFlip;
  BusArrivalList({required this.state, required this.onFlip});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onFlip('test'),
      child: Container(
        child: Text('Arrivals'),
      ),
    );
  }
}
