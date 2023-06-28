// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for hue color wheel.
class IGHueColorWheelPainter extends CustomPainter {
  const IGHueColorWheelPainter({
    required this.hsvColor,
    this.pointerColor,
    this.pointerStrokeWidth,
  });

  final HSVColor hsvColor;

  final Color? pointerColor;
  final double? pointerStrokeWidth;

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
    final Gradient gradientS = SweepGradient(colors: colors);
    const Gradient gradientR = RadialGradient(
      colors: [
        Colors.white,
        Color(0x00FFFFFF),
      ],
    );
    canvas
      ..drawCircle(
        center,
        radio,
        Paint()..shader = gradientS.createShader(rect),
      )
      ..drawCircle(
        center,
        radio,
        Paint()..shader = gradientR.createShader(rect),
      )
      ..drawCircle(
        center,
        radio,
        Paint()..color = Colors.black.withOpacity(1 - hsvColor.value),
      )
      ..drawCircle(
        Offset(
          center.dx +
              hsvColor.saturation * radio * cos(hsvColor.hue * pi / 180),
          center.dy -
              hsvColor.saturation * radio * sin(hsvColor.hue * pi / 180),
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
