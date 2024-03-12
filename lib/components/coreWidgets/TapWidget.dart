import 'package:flutter/material.dart';

class TapWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget? child;
  final double? radius;

  const TapWidget(
      {super.key, this.onTap, this.onLongPress, this.child, this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: child,
          )),
    );
  }
}
