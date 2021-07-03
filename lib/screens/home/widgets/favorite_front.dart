import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

class FavoriteFront extends StatelessWidget {
  final Favorite favorite;
  FavoriteFront({required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            height: 30,
            child: Center(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: favorite.serviceNo,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const TextSpan(
                    text: ' @ ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextSpan(
                    text: favorite.busStopCode,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue[700]),
                  ),
                ]),
              ),
            ),
          ),
          //const Divider(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF00abeb),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  'Arriving',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
