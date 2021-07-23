import 'package:flutter/material.dart';

class LocationEnableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.location_off, size: 50),
            const SizedBox(height: 20),
            Text(
                'This app uses location to see which Bus Stops are near to you. Do you want to enable locations?'),
            TextButton(onPressed: () {}, child: Text('Location Settings')),
            const SizedBox(height: 20),
            TextButton(onPressed: () {}, child: Text('Continue')),
          ],
        ),
      ),
    );
  }
}
