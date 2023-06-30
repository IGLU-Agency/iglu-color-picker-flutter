// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// The Color Picker with HUE Ring & HSV model.
class IGHueRingPicker extends StatefulWidget {
  const IGHueRingPicker({
    super.key,
    //GENERAL
    this.currentColor,
    this.onColorChanged,
    this.displayThumbColor = true,
    //DECORATION HUE RING
    this.hueRingHeight = 250.0,
    this.hueRingStrokeWidth = 20.0,
    this.hueRingBorderColor,
    this.hueRingBorderWidth,
    //DECORATION COLOR PICKER AREA
    this.areaRadius,
    this.areaBorderColor,
    this.areaBorderWidth,
    //ALL VIEWS DECORATION
    this.padding,
    this.elementSpacing = 10,
    //DECORATION COLOR PICKER ALPHA SLIDER
    this.enableAlpha = true,
    this.alphaSliderRadius,
    this.alphaSliderBorderColor,
    this.alphaSliderBorderWidth,
    //DECORATION COLOR PICKER INPUT BAR
    this.showInputBar = true,
    this.inputBarBorderColor,
    this.inputBarBorderWidth,
    this.inputBarRadius,
    this.inputBarPadding,
    this.inputBarDisable,
    this.customInputBar,
  });

  //GENERAL
  final Color? currentColor;
  final ValueChanged<Color>? onColorChanged;
  final bool displayThumbColor;

  //DECORATION HUE RING
  final double hueRingHeight;
  final double hueRingStrokeWidth;
  final Color? hueRingBorderColor;
  final double? hueRingBorderWidth;

  //DECORATION COLOR PICKER AREA
  final double? areaRadius;
  final Color? areaBorderColor;
  final double? areaBorderWidth;

  //ALL VIEWS DECORATION
  final EdgeInsetsGeometry? padding;
  final double elementSpacing;

  //DECORATION COLOR PICKER ALPHA SLIDER
  final bool enableAlpha;
  final double? alphaSliderRadius;
  final Color? alphaSliderBorderColor;
  final double? alphaSliderBorderWidth;

  //DECORATION COLOR PICKER INPUT BAR
  final bool showInputBar;
  final double? inputBarRadius;
  final Color? inputBarBorderColor;
  final double? inputBarBorderWidth;
  final EdgeInsetsGeometry? inputBarPadding;
  final bool? inputBarDisable;
  final Widget Function(Color)? customInputBar;

  @override
  IGHueRingPickerState createState() => IGHueRingPickerState();
}

class IGHueRingPickerState extends State<IGHueRingPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.currentColor ?? Colors.red);
    super.initState();
  }

  @override
  void didUpdateWidget(IGHueRingPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.currentColor ?? Colors.red);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged?.call(currentHsvColor.toColor());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                SizedBox(
                  width: widget.hueRingHeight,
                  height: widget.hueRingHeight,
                  child: IGColorPickerHueRing(
                    currentHsvColor,
                    onColorChanging,
                    displayThumbColor: widget.displayThumbColor,
                    strokeWidth: widget.hueRingStrokeWidth,
                    borderColor: widget.hueRingBorderColor,
                    borderWidth: widget.hueRingBorderWidth,
                  ),
                ),
                SizedBox(
                  width: widget.hueRingHeight / 1.6,
                  height: widget.hueRingHeight / 1.6,
                  child: IGColorPickerArea(
                    hsvColor: currentHsvColor,
                    onColorChanged: onColorChanging,
                    paletteType: IGPaletteType.hsv,
                    borderColor: widget.areaBorderColor,
                    borderWidth: widget.areaBorderWidth,
                    radius: widget.areaRadius,
                  ),
                )
              ],
            ),
          ),

          space,

          if (widget.enableAlpha)
            IGColorPickerSlider(
              trackType: IGTrackType.alpha,
              hsvColor: currentHsvColor,
              onColorChanged: onColorChanging,
              displayThumbColor: widget.displayThumbColor,
              borderColor:
                  widget.alphaSliderBorderColor ?? Colors.grey.shade400,
              borderWidth: widget.alphaSliderBorderWidth ?? 1.5,
              radius: widget.alphaSliderRadius,
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
        ],
      ),
    );
  }

  //WIDGETS

  Widget get space {
    return SizedBox(height: widget.elementSpacing);
  }
}
