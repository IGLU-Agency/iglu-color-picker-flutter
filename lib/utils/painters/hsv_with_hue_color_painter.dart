// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for SV mixture.
class IGHsvWithHueColorPainter extends CustomPainter {
  const IGHsvWithHueColorPainter({
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
      colors: [Colors.white, Colors.black],
    );
    final Gradient gradientH = LinearGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor(),
      ],
    );
    canvas
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
          ..blendMode = BlendMode.multiply
          ..shader = gradientH.createShader(rect),
      )
      ..drawCircle(
        Offset(
          size.width * hsvColor.saturation,
          size.height * (1 - hsvColor.value),
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
