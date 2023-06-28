// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for HS mixture.
class IGHsvWithValueColorPainter extends CustomPainter {
  const IGHsvWithValueColorPainter({
    required this.hsvColor,
    this.borderRadius,
    this.pointerColor,
    this.pointerStrokeWidth,
  });

  final HSVColor hsvColor;

  final double? borderRadius;

  final Color? pointerColor;
  final double? pointerStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.white],
    );
    final colors = <Color>[
      const HSVColor.fromAHSV(1, 0, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 60, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 120, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 180, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 240, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 300, 1, 1).toColor(),
      const HSVColor.fromAHSV(1, 360, 1, 1).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
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
        Paint()..shader = gradientV.createShader(rect),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius ?? 8),
        ),
        Paint()..color = Colors.black.withOpacity(1 - hsvColor.value),
      )
      ..drawCircle(
        Offset(
          size.width * hsvColor.hue / 360,
          size.height * (1 - hsvColor.saturation),
        ),
        size.height * 0.04,
        Paint()
          ..color = pointerColor ??
              (useWhiteForeground(hsvColor.toColor())
                  ? Colors.white
                  : Colors.black)
          ..strokeWidth = pointerStrokeWidth ?? 3
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
