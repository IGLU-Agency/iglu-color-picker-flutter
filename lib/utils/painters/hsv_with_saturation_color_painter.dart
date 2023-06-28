// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for HV mixture.
class IGHsvWithSaturationColorPainter extends CustomPainter {
  const IGHsvWithSaturationColorPainter({
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
      colors: [Colors.transparent, Colors.black],
    );
    final colors = <Color>[
      HSVColor.fromAHSV(1, 0, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 60, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 120, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 180, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 240, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 300, hsvColor.saturation, 1).toColor(),
      HSVColor.fromAHSV(1, 360, hsvColor.saturation, 1).toColor(),
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
      ..drawCircle(
        Offset(
          size.width * hsvColor.hue / 360,
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
