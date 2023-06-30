// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for hue ring.
class IGHueRingPainter extends CustomPainter {
  const IGHueRingPainter(
    this.hsvColor, {
    this.displayThumbColor = true,
    this.strokeWidth = 5,
    this.borderWidth,
    this.borderColor,
  });

  final HSVColor hsvColor;
  final bool displayThumbColor;
  final double strokeWidth;
  final double? borderWidth;
  final Color? borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);
    final radio = size.width <= size.height ? size.width / 2 : size.height / 2;

    final colors = <Color>[
      const HSVColor.fromAHSV(1, 360, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 300, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 240, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 180, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 120, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 60, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 0, 1, 1).toColor(),
    ];
    canvas
      ..drawCircle(
        center,
        radio,
        Paint()
          ..shader = SweepGradient(colors: colors).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth,
      )
      ..drawCircle(
        Offset(center.dx, center.dy),
        radio + (size.height * 0.04),
        Paint()
          ..color = borderColor ?? Colors.black
          ..strokeWidth = borderWidth ?? 3
          ..style = PaintingStyle.stroke,
      )
      ..drawCircle(
        Offset(center.dx, center.dy),
        radio - (size.height * 0.04),
        Paint()
          ..color = borderColor ?? Colors.black
          ..strokeWidth = borderWidth ?? 3
          ..style = PaintingStyle.stroke,
      );

    final offset = Offset(
      center.dx + radio * cos(hsvColor.hue * pi / 180),
      center.dy - radio * sin(hsvColor.hue * pi / 180),
    );

    canvas
      ..drawShadow(
        Path()..addOval(Rect.fromCircle(center: offset, radius: 12)),
        Colors.black,
        3,
        true,
      )
      ..drawCircle(
        offset,
        size.height * 0.04,
        Paint()
          ..color = (useWhiteForeground(hsvColor.toColor())
              ? Colors.white
              : Colors.black)
          ..style = PaintingStyle.fill,
      );
    if (displayThumbColor) {
      canvas.drawCircle(
        offset,
        size.height * 0.03,
        Paint()
          ..color = hsvColor.toColor()
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
