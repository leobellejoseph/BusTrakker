import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.lightBlueAccent.withOpacity(0.8),
              Colors.lightBlueAccent.withOpacity(0.4),
            ]),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
