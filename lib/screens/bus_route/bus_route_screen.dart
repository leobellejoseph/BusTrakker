import 'package:flutter/material.dart';

class BusRouteScreen extends StatelessWidget {
  final String service;
  BusRouteScreen({required this.service});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Center(
              child: Text(service,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30))),
          Expanded(
              child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: Colors.blueAccent,
                width: double.infinity,
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0, color: Colors.white),
          )),
        ],
      ),
    );
  }
}
