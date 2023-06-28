// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for GB mixture.
class IGRgbWithRedColorPainter extends CustomPainter {
  const IGRgbWithRedColorPainter({
    required this.color,
    this.borderRadius,
    this.pointerColor,
    this.pointerStrokeWidth,
  });

  final Color color;

  final double? borderRadius;

  final Color? pointerColor;
  final double? pointerStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        Color.fromRGBO(color.red, 255, 0, 1),
        Color.fromRGBO(color.red, 255, 255, 1),
      ],
    );
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(color.red, 255, 255, 1),
        Color.fromRGBO(color.red, 0, 255, 1),
      ],
    );
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius ?? 8),
        ),
        Paint()..shader = gradientH.createShader(rect),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius ?? 8),
        ),
        Paint()
          ..shader = gradientV.createShader(rect)
          ..blendMode = BlendMode.multiply,
      )
      ..drawCircle(
        Offset(
          size.width * color.blue / 255,
          size.height * (1 - color.green / 255),
        ),
        size.height * 0.04,
        Paint()
          ..color = pointerColor ??
              (useWhiteForeground(color) ? Colors.white : Colors.black)
          ..strokeWidth = pointerStrokeWidth ?? 3
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
