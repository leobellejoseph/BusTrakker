import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String caption;
  final Function onTap;
  final bool showButton;
  const NoDataWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.caption,
    required this.onTap,
    required this.showButton,
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.info_circle_fill, color: Colors.blueGrey, size: 50),
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                fontSize: 18)),
        subTitle.isNotEmpty
            ? Text(subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.black54))
            : Container(),
        showButton
            ? TextButton(
                onPressed: () => onTap(),
                child: Text(
                  caption,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.blueAccent),
                ),
              )
            : Container(),
      ],
    );
  }
}
