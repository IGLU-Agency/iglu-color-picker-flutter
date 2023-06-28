// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// The Color Picker with sliders only. Support HSV, HSL and RGB color model.
class IGSlidePicker extends StatefulWidget {
  const IGSlidePicker({
    required this.pickerColor,
    required this.onColorChanged,
    super.key,
    this.colorModel = IGColorModel.rgb,
    this.enableAlpha = true,
    this.sliderSize = const Size(260, 40),
    this.showSliderText = true,
    this.sliderTextStyle,
    this.showParams = true,
    this.labelTypes = const [],
    this.labelTextStyle,
    this.showIndicator = true,
    this.indicatorSize = const Size(280, 50),
    this.indicatorAlignmentBegin = const Alignment(-1, -3),
    this.indicatorAlignmentEnd = const Alignment(1, 3),
    this.displayThumbColor = true,
    this.indicatorBorderRadius = BorderRadius.zero,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final IGColorModel colorModel;
  final bool enableAlpha;
  final Size sliderSize;
  final bool showSliderText;
  final TextStyle? sliderTextStyle;
  final bool showParams;
  final List<IGColorLabelType> labelTypes;
  final TextStyle? labelTextStyle;
  final bool showIndicator;
  final Size indicatorSize;
  final AlignmentGeometry indicatorAlignmentBegin;
  final AlignmentGeometry indicatorAlignmentEnd;
  final bool displayThumbColor;
  final BorderRadius indicatorBorderRadius;

  @override
  State<StatefulWidget> createState() => _IGSlidePickerState();
}

class _IGSlidePickerState extends State<IGSlidePicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(IGSlidePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  Widget colorPickerSlider(IGTrackType trackType) {
    return IGColorPickerSlider(
      trackType: trackType,
      hsvColor: currentHsvColor,
      onColorChanged: (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
      displayThumbColor: widget.displayThumbColor,
      fullThumbColor: true,
    );
  }

  Widget indicator() {
    return ClipRRect(
      borderRadius: widget.indicatorBorderRadius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () {
          setState(
            () => currentHsvColor = HSVColor.fromColor(widget.pickerColor),
          );
          widget.onColorChanged(currentHsvColor.toColor());
        },
        child: Container(
          width: widget.indicatorSize.width,
          height: widget.indicatorSize.height,
          margin: const EdgeInsets.only(bottom: 15),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.pickerColor,
                widget.pickerColor,
                currentHsvColor.toColor(),
                currentHsvColor.toColor(),
              ],
              begin: widget.indicatorAlignmentBegin,
              end: widget.indicatorAlignmentEnd,
              stops: const [0.0, 0.5, 0.5, 1.0],
            ),
          ),
          child: const CustomPaint(painter: IGCheckerPainter()),
        ),
      ),
    );
  }

  String getColorParams(int pos) {
    assert(pos >= 0 && pos < 4, '');
    if (widget.colorModel == IGColorModel.rgb) {
      final color = currentHsvColor.toColor();
      return [
        color.red.toString(),
        color.green.toString(),
        color.blue.toString(),
        '${(color.opacity * 100).round()}',
      ][pos];
    } else if (widget.colorModel == IGColorModel.hsv) {
      return [
        currentHsvColor.hue.round().toString(),
        (currentHsvColor.saturation * 100).round().toString(),
        (currentHsvColor.value * 100).round().toString(),
        (currentHsvColor.alpha * 100).round().toString(),
      ][pos];
    } else if (widget.colorModel == IGColorModel.hsl) {
      final hslColor = hsvToHsl(currentHsvColor);
      return [
        hslColor.hue.round().toString(),
        (hslColor.saturation * 100).round().toString(),
        (hslColor.lightness * 100).round().toString(),
        (currentHsvColor.alpha * 100).round().toString(),
      ][pos];
    } else {
      return '??';
    }
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = 14;
    if (widget.labelTextStyle != null &&
        widget.labelTextStyle?.fontSize != null) {
      fontSize = widget.labelTextStyle?.fontSize?.toInt() ?? 14;
    }
    final trackTypes = <IGTrackType>[
      if (widget.colorModel == IGColorModel.hsv) ...[
        IGTrackType.hue,
        IGTrackType.saturation,
        IGTrackType.value
      ],
      if (widget.colorModel == IGColorModel.hsl) ...[
        IGTrackType.hue,
        IGTrackType.saturationForHSL,
        IGTrackType.lightness
      ],
      if (widget.colorModel == IGColorModel.rgb) ...[
        IGTrackType.red,
        IGTrackType.green,
        IGTrackType.blue
      ],
      if (widget.enableAlpha) ...[IGTrackType.alpha],
    ];
    final sliders = <SizedBox>[
      for (IGTrackType trackType in trackTypes)
        SizedBox(
          width: widget.sliderSize.width,
          height: widget.sliderSize.height,
          child: Row(
            children: <Widget>[
              if (widget.showSliderText)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    trackType.toString().split('.').last[0].toUpperCase(),
                    style: widget.sliderTextStyle ??
                        Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              Expanded(child: colorPickerSlider(trackType)),
              if (widget.showParams)
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: fontSize * 2 + 5),
                  child: Text(
                    getColorParams(trackTypes.indexOf(trackType)),
                    style: widget.sliderTextStyle ??
                        Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.right,
                  ),
                ),
            ],
          ),
        ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.showIndicator) indicator(),
        if (!widget.showIndicator) const SizedBox(height: 20),
        ...sliders,
        const SizedBox(height: 20),
        if (widget.labelTypes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: IGColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              colorLabelTypes: widget.labelTypes,
            ),
          ),
      ],
    );
  }
}
