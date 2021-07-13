import 'package:flutter/material.dart';

class BusStopWidget extends StatelessWidget {
  final String code;
  final String roadName;
  final String description;
  final String distance;
  final bool showServices;
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
              color: Color(0xFF1b7b90),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.5),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.lightBlue),
                  onPressed: () {},
                  child: Text(
                    'Tap to show bus services',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BusServiceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1, crossAxisSpacing: 1, crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Container(
          color: Color(0xFF008b8b),
          child: RawMaterialButton(
            highlightColor: Colors.lightBlueAccent,
            onPressed: () {},
            child: Center(
              child: Text(
                '1234',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
