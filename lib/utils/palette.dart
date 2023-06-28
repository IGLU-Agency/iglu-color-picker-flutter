// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

/// Palette types for color picker area widget.
enum IGPaletteType {
  hsv,
  hsvWithHue,
  hsvWithValue,
  hsvWithSaturation,
  hsl,
  hslWithHue,
  hslWithLightness,
  hslWithSaturation,
  rgbWithBlue,
  rgbWithGreen,
  rgbWithRed,
  hueWheel;

  String get displayName {
    switch (this) {
      case IGPaletteType.hsv:
        return 'HSV';
      case IGPaletteType.hsvWithHue:
        return 'HSV with hue';
      case IGPaletteType.hsvWithValue:
        return 'HSV with value';
      case IGPaletteType.hsvWithSaturation:
        return 'HSV with saturation';
      case IGPaletteType.hsl:
        return 'HSL';
      case IGPaletteType.hslWithHue:
        return 'HSL with hue';
      case IGPaletteType.hslWithLightness:
        return 'HSL with lightness';
      case IGPaletteType.hslWithSaturation:
        return 'HSL with saturation';
      case IGPaletteType.rgbWithBlue:
        return 'RGB with blue';
      case IGPaletteType.rgbWithGreen:
        return 'RGB with green';
      case IGPaletteType.rgbWithRed:
        return 'RGB with red';
      case IGPaletteType.hueWheel:
        return 'HUE Wheel';
    }
  }
}

/// Track types for slider picker.
enum IGTrackType {
  hue,
  saturation,
  saturationForHSL,
  value,
  lightness,
  red,
  green,
  blue,
  alpha,
}

/// Color information label type.
enum IGColorLabelType { hex, rgb, hsv, hsl }

/// Types for slider picker widget.
enum IGColorModel { rgb, hsv, hsl }
