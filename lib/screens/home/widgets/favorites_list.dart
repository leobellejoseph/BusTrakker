import 'package:flutter/material.dart';
import 'package:my_bus/models/models.dart';

class FavoritesList extends StatelessWidget {
  final List<Favorite> _favorites = [
    Favorite(
        serviceNo: '101', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '102', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '103', busStopCode: '123456', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '104', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '105', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '106', busStopCode: '123456', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '107', busStopCode: '12345', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '108', busStopCode: '67890', arrival: BusArrival.empty()),
    Favorite(
        serviceNo: '109', busStopCode: '123456', arrival: BusArrival.empty()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        itemCount: _favorites.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final favorite = _favorites[index];
          return Container(
            margin: const EdgeInsets.all(2),
            height: double.infinity,
            width: 150,
            child: _listTile(favorite),
          );
        },
      ),
    );
  }

  Widget _listTile(Favorite favorite) {
    return GestureDetector(
      onTap: () => print(favorite.serviceNo),
      child: Card(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const TextSpan(
                      text: ' @ ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      ),
    );
  }
}
