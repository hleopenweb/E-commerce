// Flutter imports:
import 'package:flutter/cupertino.dart';

class CircleIcon extends StatelessWidget {
  final Widget icon;
  final Color backgroundColor;
  final Color backgroundDisabledColor;
  final EdgeInsets padding;
  final double size;
  final VoidCallback? onPressed;

  const CircleIcon(
      {Key? key,
        this.size = 34,
        required this.icon,
        this.backgroundColor = const Color(0xff0371B8),
        this.backgroundDisabledColor = const Color(0xffA8A8A8),
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
          color: backgroundColor,
          disabledColor: backgroundDisabledColor,
          onPressed: onPressed,
          borderRadius: BorderRadius.circular(size),
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}