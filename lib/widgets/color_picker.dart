// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// The default layout of Color Picker.
class IGColorPicker extends StatefulWidget {
  const IGColorPicker({
    super.key,
    //GENERAL
    this.paletteType = IGPaletteType.hsvWithHue,
    this.currentColor,
    this.onColorChanged,

    //HISTORY
    this.historyColorsBuilder,
    this.colorHistory,
    //ALL VIEWS DECORATION
    this.enableAlpha = true,
    this.padding,
    this.elementSpacing = 10,
    //DECORATION COLOR PICKER SLIDER
    this.showSlider = true,
    this.sliderRadius,
    this.sliderBorderColor,
    this.sliderBorderWidth,
    this.displayThumbColor = true,
    //DECORATION COLOR PICKER ALPHA SLIDER
    this.alphaSliderRadius,
    this.alphaSliderBorderColor,
    this.alphaSliderBorderWidth,
    //DECORATION COLOR PICKER AREA
    this.areaWidth = 300.0,
    this.areaHeight,
    this.areaRadius,
    this.areaBorderColor,
    this.areaBorderWidth,
    //DECORATION COLOR PICKER INPUT BAR
    this.showInputBar = true,
    this.inputBarBorderColor,
    this.inputBarBorderWidth,
    this.inputBarRadius,
    this.inputBarPadding,
    this.inputBarDisable,
    this.customInputBar,
    //DECORATION COLOR PICKER COLOR DETAILS
    this.colorDetailsLabelTypes = const [
      IGColorLabelType.hex,
      IGColorLabelType.rgb,
      IGColorLabelType.hsv,
      IGColorLabelType.hsl
    ],
    this.colorDetailsWidget,
  });

  //GENERAL
  final IGPaletteType paletteType;

  final Color? currentColor;
  final ValueChanged<Color>? onColorChanged;

  //HISTORY
  final Widget Function()? historyColorsBuilder;
  final List<Color>? colorHistory;

  //ALL VIEWS DECORATION
  final EdgeInsetsGeometry? padding;
  final double elementSpacing;

  //DECORATION COLOR PICKER SLIDER
  final bool showSlider;
  final double? sliderRadius;
  final Color? sliderBorderColor;
  final double? sliderBorderWidth;
  final bool displayThumbColor;

  //DECORATION COLOR PICKER ALPHA SLIDER
  final bool enableAlpha;
  final double? alphaSliderRadius;
  final Color? alphaSliderBorderColor;
  final double? alphaSliderBorderWidth;

  //DECORATION COLOR PICKER AREA
  final double areaWidth;
  final double? areaHeight;
  final double? areaRadius;
  final Color? areaBorderColor;
  final double? areaBorderWidth;

  //DECORATION COLOR PICKER INPUT BAR

  final bool showInputBar;
  final double? inputBarRadius;
  final Color? inputBarBorderColor;
  final double? inputBarBorderWidth;
  final EdgeInsetsGeometry? inputBarPadding;
  final bool? inputBarDisable;
  final Widget Function(Color)? customInputBar;

  //DECORATION COLOR PICKER COLOR DETAILS
  final List<IGColorLabelType> colorDetailsLabelTypes;
  final Widget Function(
    List<String> hex,
    List<String> rgb,
    List<String> hsv,
    List<String> hsl,
  )? colorDetailsWidget;

  @override
  IGColorPickerState createState() => IGColorPickerState();
}

class IGColorPickerState extends State<IGColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(
      widget.currentColor ?? Colors.white,
    );
    if (widget.colorHistory != null) {
      colorHistory = widget.colorHistory ?? [];
    }
    super.initState();
  }

  @override
  void didUpdateWidget(IGColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(
      widget.currentColor ?? Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //COLOR PICKER AREA
          SizedBox(
            width: widget.areaWidth,
            height: widget.areaHeight ?? widget.areaWidth,
            child: _colorPicker,
          ),

          space,

          //COLOR PICKER SLIDER & ALPHA SLIDER
          if (widget.showSlider)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      _sliderByPaletteType,
                      space,
                      if (widget.enableAlpha)
                        _colorPickerSlider(IGTrackType.alpha),
                    ],
                  ),
                ),
              ],
            ),

          space,

          //COLOR PICKER INPUT BAR
          if (widget.showInputBar) ...[
            if (widget.customInputBar != null)
              widget.customInputBar!.call(currentHsvColor.toColor())
            else
              IGColorPickerInput(
                color: currentHsvColor.toColor(),
                onColorChanged: (Color color) {
                  setState(
                    () => currentHsvColor = HSVColor.fromColor(color),
                  );
                  widget.onColorChanged?.call(currentHsvColor.toColor());
                },
                enableAlpha: widget.enableAlpha,
                onCurrentColorTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: currentHsvColor
                          .toColor()
                          .toHexString(includeHashSign: true),
                    ),
                  );
                },
                borderColor: widget.inputBarBorderColor,
                borderWidth: widget.inputBarBorderWidth,
                padding: widget.inputBarPadding,
                radius: widget.inputBarRadius,
                disable: widget.inputBarDisable ?? false,
              ),
          ],

          space,

          //COLOR HISTORY
          if (widget.historyColorsBuilder != null) ...[
            widget.historyColorsBuilder!.call()
          ] else if (colorHistory.isNotEmpty) ...[
            SizedBox(
              width: widget.areaWidth,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (Color color in colorHistory)
                    Padding(
                      key: Key(color.hashCode.toString()),
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Center(
                        child: GestureDetector(
                          onTap: () =>
                              onColorChanging(HSVColor.fromColor(color)),
                          child: IGColorIndicator(
                            HSVColor.fromColor(color),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],

          space,

          //COLOR TYPES SPEC
          if (widget.colorDetailsLabelTypes.isNotEmpty ||
              widget.colorDetailsWidget != null)
            IGColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              colorLabelTypes: widget.colorDetailsLabelTypes,
              widget: widget.colorDetailsWidget,
            ),
        ],
      ),
    );
  }

  //UTILS
  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged?.call(currentHsvColor.toColor());
  }

  //WIDGETS
  Widget get _sliderByPaletteType {
    switch (widget.paletteType) {
      case IGPaletteType.hsv:
      case IGPaletteType.hsvWithHue:
      case IGPaletteType.hsl:
      case IGPaletteType.hslWithHue:
        return _colorPickerSlider(IGTrackType.hue);
      case IGPaletteType.hsvWithValue:
      case IGPaletteType.hueWheel:
        return _colorPickerSlider(IGTrackType.value);
      case IGPaletteType.hsvWithSaturation:
        return _colorPickerSlider(IGTrackType.saturation);
      case IGPaletteType.hslWithLightness:
        return _colorPickerSlider(IGTrackType.lightness);
      case IGPaletteType.hslWithSaturation:
        return _colorPickerSlider(IGTrackType.saturationForHSL);
      case IGPaletteType.rgbWithBlue:
        return _colorPickerSlider(IGTrackType.blue);
      case IGPaletteType.rgbWithGreen:
        return _colorPickerSlider(IGTrackType.green);
      case IGPaletteType.rgbWithRed:
        return _colorPickerSlider(IGTrackType.red);
    }
  }

  Widget _colorPickerSlider(IGTrackType trackType) {
    return IGColorPickerSlider(
      trackType: trackType,
      hsvColor: currentHsvColor,
      onColorChanged: (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged?.call(currentHsvColor.toColor());
      },
      displayThumbColor: widget.displayThumbColor,
      borderColor: trackType == IGTrackType.alpha
          ? widget.alphaSliderBorderColor ?? Colors.grey.shade400
          : widget.sliderBorderColor ?? Colors.black,
      borderWidth: trackType == IGTrackType.alpha
          ? widget.alphaSliderBorderWidth ?? 1.5
          : widget.sliderBorderWidth ?? 3,
      radius: trackType == IGTrackType.alpha
          ? widget.alphaSliderRadius
          : widget.sliderRadius,
    );
  }

  Widget get _colorPicker {
    return Padding(
      padding:
          EdgeInsets.all(widget.paletteType == IGPaletteType.hueWheel ? 10 : 0),
      child: IGColorPickerArea(
        hsvColor: currentHsvColor,
        onColorChanged: onColorChanging,
        paletteType: widget.paletteType,
        borderColor: widget.areaBorderColor,
        borderWidth: widget.areaBorderWidth,
        radius: widget.areaRadius,
      ),
    );
  }

  Widget get space {
    return SizedBox(height: widget.elementSpacing);
  }
}
