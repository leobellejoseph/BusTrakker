import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends HookWidget {
  final String asset;
  final Size _size;
  const LottieWidget({Key? key, required this.asset, Size? size})
      : _size = size ?? const Size(50, 50),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController();
    return Lottie.asset(
      asset,
      height: _size.height,
      width: _size.width,
      repeat: true,
      controller: controller,
      onLoaded: (composition) {
        controller
          ..duration = composition.duration
          ..repeat();
      },
    );
  }
}
