// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Provide Rectangle & Circle 2 categories, 10 variations of palette widget.
class IGColorPickerArea extends StatelessWidget {
  const IGColorPickerArea({
    required this.hsvColor,
    required this.onColorChanged,
    required this.paletteType,
    super.key,
    this.radius,
    this.borderWidth,
    this.borderColor,
  });

  final double? radius;
  final double? borderWidth;
  final Color? borderColor;

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final IGPaletteType paletteType;

  void _handleColorRectChange(double horizontal, double vertical) {
    switch (paletteType) {
      case IGPaletteType.hsv:
      case IGPaletteType.hsvWithHue:
        onColorChanged(hsvColor.withSaturation(horizontal).withValue(vertical));
      case IGPaletteType.hsvWithSaturation:
        onColorChanged(hsvColor.withHue(horizontal * 360).withValue(vertical));
      case IGPaletteType.hsvWithValue:
        onColorChanged(
          hsvColor.withHue(horizontal * 360).withSaturation(vertical),
        );
      case IGPaletteType.hsl:
      case IGPaletteType.hslWithHue:
        onColorChanged(
          hslToHsv(
            hsvToHsl(hsvColor)
                .withSaturation(horizontal)
                .withLightness(vertical),
          ),
        );
      case IGPaletteType.hslWithSaturation:
        onColorChanged(
          hslToHsv(
            hsvToHsl(hsvColor)
                .withHue(horizontal * 360)
                .withLightness(vertical),
          ),
        );
      case IGPaletteType.hslWithLightness:
        onColorChanged(
          hslToHsv(
            hsvToHsl(hsvColor)
                .withHue(horizontal * 360)
                .withSaturation(vertical),
          ),
        );
      case IGPaletteType.rgbWithRed:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor
                .toColor()
                .withBlue((horizontal * 255).round())
                .withGreen((vertical * 255).round()),
          ),
        );
      case IGPaletteType.rgbWithGreen:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor
                .toColor()
                .withBlue((horizontal * 255).round())
                .withRed((vertical * 255).round()),
          ),
        );
      case IGPaletteType.rgbWithBlue:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor
                .toColor()
                .withRed((horizontal * 255).round())
                .withGreen((vertical * 255).round()),
          ),
        );
      case IGPaletteType.hueWheel:
    }
  }

  void _handleColorWheelChange(double hue, double radio) {
    onColorChanged(hsvColor.withHue(hue).withSaturation(radio));
  }

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

    if (paletteType == IGPaletteType.hueWheel) {
      final center = Offset(width / 2, height / 2);
      final radio = width <= height ? width / 2 : height / 2;
      final dist =
          sqrt(pow(horizontal - center.dx, 2) + pow(vertical - center.dy, 2)) /
              radio;
      final rad =
          (atan2(horizontal - center.dx, vertical - center.dy) / pi + 1) /
              2 *
              360;
      _handleColorWheelChange(
        ((rad + 90) % 360).clamp(0, 360),
        dist.clamp(0, 1),
      );
    } else {
      _handleColorRectChange(horizontal / width, 1 - vertical / height);
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Builder(
              builder: (BuildContext _) {
                switch (paletteType) {
                  case IGPaletteType.hsv:
                  case IGPaletteType.hsvWithHue:
                    return _containerPainter(
                      painter: IGHsvWithHueColorPainter(
                        hsvColor: hsvColor,
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hsvWithSaturation:
                    return _containerPainter(
                      painter: IGHsvWithSaturationColorPainter(
                        hsvColor: hsvColor,
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hsvWithValue:
                    return _containerPainter(
                      painter: IGHsvWithValueColorPainter(
                        hsvColor: hsvColor,
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hsl:
                  case IGPaletteType.hslWithHue:
                    return _containerPainter(
                      painter: IGHslWithHueColorPainter(
                        hslColor: hsvToHsl(hsvColor),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hslWithSaturation:
                    return _containerPainter(
                      painter: IGHslWithSaturationColorPainter(
                        hslColor: hsvToHsl(hsvColor),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hslWithLightness:
                    return _containerPainter(
                      painter: IGHslWithLightnessColorPainter(
                        hslColor: hsvToHsl(hsvColor),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.rgbWithRed:
                    return _containerPainter(
                      painter: IGRgbWithRedColorPainter(
                        color: hsvColor.toColor(),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.rgbWithGreen:
                    return _containerPainter(
                      painter: IGRgbWithGreenColorPainter(
                        color: hsvColor.toColor(),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.rgbWithBlue:
                    return _containerPainter(
                      painter: IGRgbWithBlueColorPainter(
                        color: hsvColor.toColor(),
                        borderRadius: radius != null ? radius! - 3 : 5,
                      ),
                    );
                  case IGPaletteType.hueWheel:
                    return _containerPainter(
                      isCircle: true,
                      painter: IGHueColorWheelPainter(
                        hsvColor: hsvColor,
                      ),
                    );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _containerPainter({
    required CustomPainter painter,
    bool isCircle = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isCircle ? null : BorderRadius.circular(radius ?? 8),
        border: Border.all(
          color: borderColor ?? Colors.black,
          width: borderWidth ?? 3,
        ),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 8),
        clipBehavior: Clip.none,
        child: CustomPaint(
          painter: painter,
        ),
      ),
    );
  }
}
