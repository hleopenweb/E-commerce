// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_activity_indicator.dart';
import 'label.dart';

enum CustomButtonStyle { empty, filled }

class CustomButton extends StatelessWidget {
  final CustomButtonStyle style;
  final String? title;
  final double minWidth;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final bool isLoading;
  final bool showBorder;
  final Widget? icon;
  final bool iconOnRightEdge;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    this.style = CustomButtonStyle.filled,
    this.title,
    this.minWidth = 80,
    this.height = 44,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w400,
    this.padding = const EdgeInsets.all(8),
    this.isLoading = false,
    this.showBorder = false,
    this.onPressed,
    this.icon,
    this.iconOnRightEdge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = style == CustomButtonStyle.filled
        ? Color(0x0ff371b8)
        : Colors.transparent;
    final disabledColor = style == CustomButtonStyle.filled
        ? color.withAlpha(120)
        : Colors.transparent;
    final indicatorColor = style == CustomButtonStyle.filled
        ? Colors.white
        : Color(0x0ff371b8);
    return Container(
      height: height,
      decoration: showBorder
          ? BoxDecoration(
        border: Border.all(color: Color(0x0ff371b8), width: 1),
        borderRadius: BorderRadius.circular(10),
      )
          : null,
      child: CupertinoButton(
        minSize: minWidth,
        color: color,
        disabledColor: disabledColor,
        onPressed: onPressed != null
            ? () {
          if (!isLoading) {
            onPressed?.call();
          }
        }
            : null,
        borderRadius: BorderRadius.circular(10),
        padding: padding,
        child: isLoading
            ? SizedBox(
          height: height / 2,
          width: height / 2,
          child: AppActivityIndicator(
            color: indicatorColor,
          ),
        )
            : _iconAndTitle(),
      ),
    );
  }

  Widget _iconAndTitle() {
    final textColor = style == CustomButtonStyle.filled
        ? Colors.white
        : Color(0x0ff371b8);
    final disabledTextColor = style == CustomButtonStyle.filled
        ? textColor
        : Color(0x0ffa8a8a);
    final icon = this.icon;
    final List<Widget> iconAndTitle = [];
    if (title != null) {
      iconAndTitle.add(
        Flexible(
          child: Label(
              text: title ?? '',
              size: fontSize,
              weight: fontWeight,
              align: TextAlign.center,
              color: onPressed != null ? textColor : disabledTextColor,
              maxLines: 2),
        ),
      );
    }
    if (icon != null) {
      if (iconOnRightEdge) {
        iconAndTitle.addAll([if (title != null) const SizedBox(width: 8), icon]);
      } else {
        iconAndTitle.insertAll(0, [icon, if (title != null) const SizedBox(width: 8)]);
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconAndTitle,
    );
  }
}
