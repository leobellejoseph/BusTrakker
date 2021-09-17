import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

class BusStopHeader extends StatelessWidget {
  final BusStop item;
  final bool _showDistance;
  const BusStopHeader({
    Key? key,
    required this.item,
    bool showDistance = false,
  })  : _showDistance = showDistance,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Color(0xFF79ab8c),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              _showDistance == true && item.distanceDisplay.isNotEmpty
                  ? TextSpan(
                      text: '${item.distanceDisplay}km @ ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  : TextSpan(),
              TextSpan(
                text: item.roadName,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
