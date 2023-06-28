// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Provide Hue Ring with HSV Rectangle of palette widget.
class IGColorPickerHueRing extends StatelessWidget {
  const IGColorPickerHueRing(
    this.hsvColor,
    this.onColorChanged, {
    super.key,
    this.displayThumbColor = true,
    this.strokeWidth = 5.0,
  });

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;
  final double strokeWidth;

  void _handleGesture(
    Offset position,
    BuildContext context,
    double height,
    double width,
  ) {
    final getBox = context.findRenderObject() as RenderBox?;
    if (getBox == null) return;

    final localOffset = getBox.globalToLocal(position);
    final horizontal = localOffset.dx.clamp(0.0, width);
    final vertical = localOffset.dy.clamp(0.0, height);

    final center = Offset(width / 2, height / 2);
    final radio = width <= height ? width / 2 : height / 2;
    final dist =
        sqrt(pow(horizontal - center.dx, 2) + pow(vertical - center.dy, 2)) /
            radio;
    final rad = (atan2(horizontal - center.dx, vertical - center.dy) / pi + 1) /
        2 *
        360;
    if (dist > 0.7 && dist < 1.3) {
      onColorChanged(hsvColor.withHue(((rad + 90) % 360).clamp(0, 360)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return RawGestureDetector(
          gestures: {
            AlwaysWinPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                AlwaysWinPanGestureRecognizer>(
              AlwaysWinPanGestureRecognizer.new,
              (AlwaysWinPanGestureRecognizer instance) {
                instance
                  ..onDown = ((details) => _handleGesture(
                        details.globalPosition,
                        context,
                        height,
                        width,
                      ))
                  ..onUpdate = ((details) => _handleGesture(
                        details.globalPosition,
                        context,
                        height,
                        width,
                      ));
              },
            ),
          },
          child: CustomPaint(
            painter: IGHueRingPainter(
              hsvColor,
              displayThumbColor: displayThumbColor,
              strokeWidth: strokeWidth,
            ),
          ),
        );
      },
    );
  }
}
