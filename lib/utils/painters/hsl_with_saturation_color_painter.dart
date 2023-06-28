// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for HL mixture.
class IGHslWithSaturationColorPainter extends CustomPainter {
  const IGHslWithSaturationColorPainter({
    required this.hslColor,
    this.borderRadius,
    this.pointerColor,
    this.pointerStrokeWidth,
  });

  final HSLColor hslColor;

  final double? borderRadius;

  final Color? pointerColor;
  final double? pointerStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final colors = <Color>[
      HSLColor.fromAHSL(1, 0, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 60, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 120, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 180, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 240, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 300, hslColor.saturation, 0.5).toColor(),
      HSLColor.fromAHSL(1, 360, hslColor.saturation, 0.5).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        Color(0x00ffffff),
        Colors.transparent,
        Colors.black,
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
        Paint()..shader = gradientV.createShader(rect),
      )
      ..drawCircle(
        Offset(
          size.width * hslColor.hue / 360,
          size.height * (1 - hslColor.lightness),
        ),
        size.height * 0.04,
        Paint()
          ..color = pointerColor ??
              (useWhiteForeground(hslColor.toColor())
                  ? Colors.white
                  : Colors.black)
          ..strokeWidth = pointerStrokeWidth ?? 3
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
