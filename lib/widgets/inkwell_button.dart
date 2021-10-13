import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final Function onPress;
  final Widget widget;
  final Color pressColor;
  final ShapeBorder shape;
  final Color materialColor;
  final BorderRadius radius;
  InkWellButton(
      {Key? key,
      required this.onPress,
      required this.widget,
      Color? highlightColor,
      ShapeBorder? border,
      Color? shapeColor,
      BorderRadius? borderRadius})
      : materialColor = shapeColor ?? Colors.transparent,
        pressColor = highlightColor ?? Colors.lightBlueAccent,
        shape = border ?? const CircleBorder(),
        radius = borderRadius ?? BorderRadius.circular(0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: radius,
      color: materialColor,
      child: InkWell(
        borderRadius: radius,
        highlightColor: pressColor,
        customBorder: shape,
        onTap: () => onPress(),
        child: widget,
      ),
    );
  }
}
