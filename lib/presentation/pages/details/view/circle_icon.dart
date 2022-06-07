// Flutter imports:
import 'package:flutter/cupertino.dart';

class CircleIcon extends StatelessWidget {
  final Widget icon;
  final EdgeInsets padding;
  final double size;
  final VoidCallback? onPressed;

  const CircleIcon(
      {Key? key,
        this.size = 34,
        required this.icon,
        this.padding = const EdgeInsets.all(7),
        this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: SizedBox(
        height: size,
        width: size,
        child: CupertinoButton(
          onPressed: onPressed,
          borderRadius: BorderRadius.circular(size),
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}