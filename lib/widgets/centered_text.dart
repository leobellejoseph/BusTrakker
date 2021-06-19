import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;
  CenteredText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }
}
