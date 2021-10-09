import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialogue extends StatelessWidget {
  final String title;
  final String content;
  ErrorDialogue({
    required this.title,
    required this.content,
  });

  CupertinoAlertDialog _showIOSDialog(context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
  AlertDialog _showAndroidDialog(context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            style:ElevatedButton.styleFrom(shape: StadiumBorder()),
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _showIOSDialog(context)
        : _showAndroidDialog(context);
  }
}
