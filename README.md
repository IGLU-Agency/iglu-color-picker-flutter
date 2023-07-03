[![Iglu Color Picker Flutter Logo][logo_white]][iglu_color_picker_flutter_link_dark]
[![Iglu Color Picker Flutter Logo][logo_black]][iglu_color_picker_flutter_link_light]

[![pub package](https://img.shields.io/pub/v/iglu_color_picker_flutter?include_prereleases.svg "IGLU COLOR PICKER FLUTTER")](https://pub.dev/packages/iglu_color_picker_flutter)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A highly customizable color picker for Flutter 🎯

Developed with 💙 by [IGLU][iglu_link]

## Quick Start 🚀

There are three types of widgets available:
- Color Picker
- Hue Ring Picker
- Slider Picker

### Color Picker

![Color Picker][image_color_picker]

You can use the color picker by simply adding this little snippet to your code

```dart
IGColorPicker(
  paletteType: IGPaletteType.hsvWithHue,
  onColorChanged: (color) {
    // Do something with color
  },
)
```

You can control just about anything with the following parameters:

```dart

// Widget type
final IGPaletteType paletteType;
// Starting color of the widget.
final Color? currentColor;
// Function to manage the color change of the value
final ValueChanged<Color>? onColorChanged;

// Builder to build dynamic history widgets
final Widget Function(List<Color>)? historyColorsBuilder;
// List of colors to show in history (it is not used if the builder is used)
final List<Color>? colorHistory;

// Padding of the whole view
final EdgeInsetsGeometry? padding;
// Height between one element and another
final double elementSpacing;

// show or hide the slider
final bool showSlider;
// Color Slider border width
final double? sliderRadius;
// Color Slider border color
final Color? sliderBorderColor;
// Color Slider border width
final double? sliderBorderWidth;
// Color Slider show / hide thumb color
final bool displayThumbColor;

// show or hide the alpha slider
final bool enableAlpha;
// Alpha Slider border radius
final double? alphaSliderRadius;
// Alpha Slider border color
final Color? alphaSliderBorderColor;
// Alpha Slider border width
final double? alphaSliderBorderWidth;

// Area border width
final double areaWidth;
// Area border height
final double? areaHeight;
// Area border radius
final double? areaRadius;
// Area border color
final Color? areaBorderColor;
// Area border width
final double? areaBorderWidth;

// show or hide the input bar
final bool showInputBar;
// InputBar border radius
final double? inputBarRadius;
// InputBar border color
final Color? inputBarBorderColor;
// InputBar border width
final double? inputBarBorderWidth;
// InputBar padding
final EdgeInsetsGeometry? inputBarPadding;
// Disable the InputBar interaction
final bool? inputBarDisable;
// Function to generate a custom widget for the input bar
final Widget Function(Color)? customInputBar;

// show color information or not (example rgb), you can hide it by passing empty array.
final List<IGColorLabelType> colorDetailsLabelTypes;
// Function to generate a custom widget for color information
final Widget Function(
  List<String> hex,
  List<String> rgb,
  List<String> hsv,
  List<String> hsl,
)? colorDetailsWidget;

```

### Hue Ring Picker

![Hue Ring Picker][image_hue_ring]

You can use the hue ring picker by simply adding this little snippet to your code

```dart

IGHueRingPicker(
  onColorChanged: (color) {
    // Do something with color
  },
)

```

You can control just about anything with the following parameters:


```dart

// Starting color of the widget.
final Color? currentColor;
// Function to manage the color change of the value
final ValueChanged<Color>? onColorChanged;
// Color Slider show / hide thumb color
final bool displayThumbColor;

// Hue Ring height
final double hueRingHeight;
// Hue Ring stroke width
final double hueRingStrokeWidth;
// Hue Ring border color
final Color? hueRingBorderColor;
// Hue Ring border width
final double? hueRingBorderWidth;

// Area border radius
final double? areaRadius;
// Area border color
final Color? areaBorderColor;
// Area border width
final double? areaBorderWidth;

// Padding of the whole view
final EdgeInsetsGeometry? padding;
// Height between one element and another
final double elementSpacing;

// show or hide the alpha slider
final bool enableAlpha;
// Alpha Slider border radius
final double? alphaSliderRadius;
// Alpha Slider border color
final Color? alphaSliderBorderColor;
// Alpha Slider border width
final double? alphaSliderBorderWidth;

// show or hide the input bar
final bool showInputBar;
// InputBar border radius
final double? inputBarRadius;
// InputBar border color
final Color? inputBarBorderColor;
// InputBar border width
final double? inputBarBorderWidth;
// InputBar padding
final EdgeInsetsGeometry? inputBarPadding;
// Disable the InputBar interaction
final bool? inputBarDisable;
// Function to generate a custom widget for the input bar
final Widget Function(Color)? customInputBar;

```


### Slider Picker

![Slider Picker][image_slider_picker]

You can use the slide picker by simply adding this little snippet to your code

```dart

IGSlidePicker(
  onColorChanged: (color) {
    // Do something with color
  },
)

```

You can control just about anything with the following parameters:


```dart

// Starting color of the widget.
final Color? currentColor;
// Function to manage the color change of the value
final ValueChanged<Color>? onColorChanged;
// Color Type (RGB, HSL, HSV)
final IGColorModel colorModel;

// show or hide color indicator
final bool showColorIndicator;
// color indicator height
final double? colorIndicatorHeight;
// color indicator border color
final Color? colorIndicatorBorderColor;
// color indicator border width
final double? colorIndicatorBorderWidth;
// color indicator border radius
final double? colorIndicatorRadius;
// color indicator alignment begin
final AlignmentGeometry colorIndicatorAlignmentBegin;
// color indicator alignment end
final AlignmentGeometry colorIndicatorAlignmentEnd;


// show or hide the slider
final bool showSlider;
// show or hide the slider params
final bool showSliderParams;
// show or hide the slider text
final bool showSliderText;
// Color Slider border width
final double? sliderRadius;
// Color Slider border color
final Color? sliderBorderColor;
// Color Slider border width
final double? sliderBorderWidth;
// custom text style
final TextStyle? sliderTextStyle;
// Color Slider show / hide thumb color
final bool displayThumbColor;


// show or hide the alpha slider
final bool enableAlpha;
// Alpha Slider border radius
final double? alphaSliderRadius;
// Alpha Slider border color
final Color? alphaSliderBorderColor;
// Alpha Slider border width
final double? alphaSliderBorderWidth;

// Padding of the whole view
final EdgeInsetsGeometry? padding;
// Height between one element and another
final double elementSpacing;

// show color information or not (example rgb), you can hide it by passing empty array.
final List<IGColorLabelType> colorDetailsLabelTypes;
// Function to generate a custom widget for color information
final Widget Function(
  List<String> hex,
  List<String> rgb,
  List<String> hsv,
  List<String> hsl,
)? colorDetailsWidget;

```


### Example

For full details explore the examples in [example](https://github.com/IGLU-Agency/iglu-color-picker-flutter/tree/master/example) folder.

[iglu_color_picker_flutter_link_dark]: https://github.com/IGLU-Agency/iglu-color-picker-flutter#gh-dark-mode-only
[iglu_color_picker_flutter_link_light]: https://github.com/IGLU-Agency/iglu-color-picker-flutter#gh-light-mode-only
[iglu_link]: https://iglu.dev
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/IGLU-Agency/iglu-color-picker-flutter/main/assets/iglu_color_picker_flutter_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/IGLU-Agency/iglu-color-picker-flutter/main/assets/iglu_color_picker_flutter_logo_white.png#gh-dark-mode-only
[image_color_picker]: https://raw.githubusercontent.com/IGLU-Agency/iglu-color-picker-flutter/main/assets/color_picker.png
[image_hue_ring]: https://raw.githubusercontent.com/IGLU-Agency/iglu-color-picker-flutter/main/assets/hue_ring.png
[image_slider_picker]: https://raw.githubusercontent.com/IGLU-Agency/iglu-color-picker-flutter/main/assets/slider_picker.png
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis