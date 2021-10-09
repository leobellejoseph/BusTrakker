import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

class BusStopLabel extends StatelessWidget {
  final BusStop item;
  const BusStopLabel({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      decoration: BoxDecoration(
        color: Color(0xFF1b7b90),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                item.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                item.busStopCode,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
