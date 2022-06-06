// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:

class AppActivityIndicator extends StatelessWidget {
  final Color color;
  final bool isAnimating;
  const AppActivityIndicator({
    Key? key,
    this.color = const Color(0x0ff037b8),
    this.isAnimating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      animating: isAnimating,
      radius: 12,
    );
  }
}
