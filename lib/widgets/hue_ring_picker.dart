// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/widgets.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// The Color Picker with HUE Ring & HSV model.
class IGHueRingPicker extends StatefulWidget {
  const IGHueRingPicker({
    required this.pickerColor,
    required this.onColorChanged,
    super.key,
    this.portraitOnly = false,
    this.colorPickerHeight = 250.0,
    this.hueRingStrokeWidth = 20.0,
    this.enableAlpha = false,
    this.displayThumbColor = true,
    this.pickerAreaBorderRadius = BorderRadius.zero,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final bool portraitOnly;
  final double colorPickerHeight;
  final double hueRingStrokeWidth;
  final bool enableAlpha;
  final bool displayThumbColor;
  final BorderRadius pickerAreaBorderRadius;

  @override
  IGHueRingPickerState createState() => IGHueRingPickerState();
}

class IGHueRingPickerState extends State<IGHueRingPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
    super.initState();
  }

  @override
  void didUpdateWidget(IGHueRingPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait ||
        widget.portraitOnly) {
      return Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: widget.pickerAreaBorderRadius,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  SizedBox(
                    width: widget.colorPickerHeight,
                    height: widget.colorPickerHeight,
                    child: IGColorPickerHueRing(
                      currentHsvColor,
                      onColorChanging,
                      displayThumbColor: widget.displayThumbColor,
                      strokeWidth: widget.hueRingStrokeWidth,
                    ),
                  ),
                  SizedBox(
                    width: widget.colorPickerHeight / 1.6,
                    height: widget.colorPickerHeight / 1.6,
                    child: IGColorPickerArea(
                      hsvColor: currentHsvColor,
                      onColorChanged: onColorChanging,
                      paletteType: IGPaletteType.hsv,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (widget.enableAlpha)
            SizedBox(
              height: 40,
              width: widget.colorPickerHeight,
              child: IGColorPickerSlider(
                trackType: IGTrackType.alpha,
                hsvColor: currentHsvColor,
                onColorChanged: onColorChanging,
                displayThumbColor: widget.displayThumbColor,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 10),
                IGColorIndicator(currentHsvColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                    child: IGColorPickerInput(
                      color: currentHsvColor.toColor(),
                      onColorChanged: (Color color) {
                        setState(
                          () => currentHsvColor = HSVColor.fromColor(color),
                        );
                        widget.onColorChanged(currentHsvColor.toColor());
                      },
                      enableAlpha: widget.enableAlpha,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: 300,
              height: widget.colorPickerHeight,
              child: ClipRRect(
                borderRadius: widget.pickerAreaBorderRadius,
                child: IGColorPickerArea(
                  hsvColor: currentHsvColor,
                  onColorChanged: onColorChanging,
                  paletteType: IGPaletteType.hsv,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: widget.pickerAreaBorderRadius,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  SizedBox(
                    width: widget.colorPickerHeight -
                        widget.hueRingStrokeWidth * 2,
                    height: widget.colorPickerHeight -
                        widget.hueRingStrokeWidth * 2,
                    child: IGColorPickerHueRing(
                      currentHsvColor,
                      onColorChanging,
                      strokeWidth: widget.hueRingStrokeWidth,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: widget.colorPickerHeight / 8.5),
                      IGColorIndicator(currentHsvColor),
                      const SizedBox(height: 10),
                      IGColorPickerInput(
                        color: currentHsvColor.toColor(),
                        onColorChanged: (Color color) {
                          setState(
                            () => currentHsvColor = HSVColor.fromColor(color),
                          );
                          widget.onColorChanged(currentHsvColor.toColor());
                        },
                        enableAlpha: widget.enableAlpha,
                        disable: true,
                      ),
                      if (widget.enableAlpha) const SizedBox(height: 5),
                      if (widget.enableAlpha)
                        SizedBox(
                          height: 40,
                          width: (widget.colorPickerHeight -
                                  widget.hueRingStrokeWidth * 2) /
                              2,
                          child: IGColorPickerSlider(
                            trackType: IGTrackType.alpha,
                            hsvColor: currentHsvColor,
                            onColorChanged: onColorChanging,
                            displayThumbColor: true,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
