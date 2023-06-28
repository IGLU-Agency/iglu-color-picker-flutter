// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for HS mixture.
class IGHslWithLightnessColorPainter extends CustomPainter {
  const IGHslWithLightnessColorPainter({
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
      const HSLColor.fromAHSL(1, 0, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 60, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 120, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 180, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 240, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 300, 1, 0.5).toColor(),
      const HSLColor.fromAHSL(1, 360, 1, 0.5).toColor(),
    ];
    final Gradient gradientH = LinearGradient(colors: colors);
    const Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Color(0xFF808080),
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
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius ?? 8),
        ),
        Paint()
          ..color = Colors.black
              .withOpacity((1 - hslColor.lightness * 2).clamp(0, 1)),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius ?? 8),
        ),
        Paint()
          ..color = Colors.white
              .withOpacity(((hslColor.lightness - 0.5) * 2).clamp(0, 1)),
      )
      ..drawCircle(
        Offset(
          size.width * hslColor.hue / 360,
          size.height * (1 - hslColor.saturation),
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
