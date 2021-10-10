import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String text;
  const CenteredText({required this.text});

  factory CenteredText.noInternet() =>
      CenteredText(text: 'No Internet Connection');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class CenteredTextButton extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;
  CenteredTextButton(
      {required this.title, required this.subTitle, required this.onTap});
  factory CenteredTextButton.refresh({required Function onClick}) =>
      CenteredTextButton(
          title: 'No Data. Tap to refresh.',
          subTitle: '',
          onTap: () => onClick());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blueAccent),
              onPressed: () => onTap(),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
