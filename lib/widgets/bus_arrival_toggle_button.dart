import 'package:flutter/material.dart';

class BusArrivalToggleButton extends StatelessWidget {
  final Function onShowRoute;
  final String service;
  final Function onFlip;
  const BusArrivalToggleButton(
      {Key? key,
      required this.onFlip,
      required this.onShowRoute,
      required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
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
                onPressed: () => onShowRoute(),
                child: Center(
                  child: Text(
                    service,
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
    );
  }
}
