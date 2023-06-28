// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';

/// Painter for thumb of slider.
class IGThumbPainter extends CustomPainter {
  const IGThumbPainter({
    required this.color,
    this.shadowColor,
    this.thumbColor,
    this.fullThumbColor = false,
  });

  final Color color;
  final Color? thumbColor;
  final Color? shadowColor;
  final bool fullThumbColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawShadow(
        Path()
          ..addOval(
            Rect.fromCircle(
              center: const Offset(0.5, 2),
              radius: size.width * 1.8,
            ),
          ),
        shadowColor ?? Colors.black,
        3,
        true,
      )
      ..drawCircle(
        Offset.zero,
        size.height / 2,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
    if (thumbColor != null) {
      canvas.drawCircle(
        Offset.zero,
        (size.height / 2) * (fullThumbColor ? 1.1 : 0.8),
        Paint()
          ..color = thumbColor!
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
