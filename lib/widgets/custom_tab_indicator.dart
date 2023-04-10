import 'package:flutter/material.dart';
import 'package:foodit/core/theme/app_color.dart';

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CustomIndicatorPainter(this, onChanged!);
  }
}

class _CustomIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomIndicatorPainter(this.decoration, VoidCallback onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(offset.dx, (configuration.size!.height) / 2 - 18) &
        Size(configuration.size!.width, 36);
    final Paint paint = Paint();
    paint.color = AppColor.light.primaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(16)), paint);
  }
}
