import 'package:flutter/material.dart';
import 'package:my_bus/cubit/cubit.dart';

class BusServiceList extends StatelessWidget {
  final BusArrivalsState state;
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
