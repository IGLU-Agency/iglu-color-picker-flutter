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
    super.key,
    this.currentColor,
    this.onColorChanged,
    this.colorModel = IGColorModel.rgb,
    //DECORATION COLOR INDICATOR
    this.showColorIndicator = false,
    this.colorIndicatorHeight,
    this.colorIndicatorBorderColor,
    this.colorIndicatorBorderWidth,
    this.colorIndicatorRadius,
    this.colorIndicatorAlignmentBegin = const Alignment(-1, -3),
    this.colorIndicatorAlignmentEnd = const Alignment(1, 3),
    //DECORATION COLOR PICKER SLIDER
    this.showSlider = true,
    this.showSliderParams = true,
    this.showSliderText = true,
    this.sliderRadius,
    this.sliderBorderColor,
    this.sliderBorderWidth,
    this.sliderTextStyle,
    this.displayThumbColor = true,
    //DECORATION COLOR PICKER ALPHA SLIDER
    this.enableAlpha = true,
    this.alphaSliderRadius,
    this.alphaSliderBorderColor,
    this.alphaSliderBorderWidth,
    //ALL VIEWS DECORATION
    this.padding,
    this.elementSpacing = 10,
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
  final Color? currentColor;
  final ValueChanged<Color>? onColorChanged;
  final IGColorModel colorModel;
  //DECORATION COLOR INDICATOR
  final bool showColorIndicator;
  final double? colorIndicatorHeight;
  final Color? colorIndicatorBorderColor;
  final double? colorIndicatorBorderWidth;
  final double? colorIndicatorRadius;
  final AlignmentGeometry colorIndicatorAlignmentBegin;
  final AlignmentGeometry colorIndicatorAlignmentEnd;
  //DECORATION COLOR PICKER SLIDER
  final bool showSlider;
  final bool showSliderParams;
  final bool showSliderText;
  final double? sliderRadius;
  final Color? sliderBorderColor;
  final double? sliderBorderWidth;
  final TextStyle? sliderTextStyle;
  final bool displayThumbColor;
  //DECORATION COLOR PICKER ALPHA SLIDER
  final bool enableAlpha;
  final double? alphaSliderRadius;
  final Color? alphaSliderBorderColor;
  final double? alphaSliderBorderWidth;
  //ALL VIEWS DECORATION
  final EdgeInsetsGeometry? padding;
  final double elementSpacing;
  //DECORATION COLOR PICKER COLOR DETAILS
  final List<IGColorLabelType> colorDetailsLabelTypes;
  final Widget Function(
    List<String> hex,
    List<String> rgb,
    List<String> hsv,
    List<String> hsl,
  )? colorDetailsWidget;

  @override
  State<StatefulWidget> createState() => _IGSlidePickerState();
}

class _IGSlidePickerState extends State<IGSlidePicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.currentColor ?? Colors.red);
  }

  @override
  void didUpdateWidget(IGSlidePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.currentColor ?? Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16;

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
    final sliders = [
      for (IGTrackType trackType in trackTypes)
        Row(
          children: <Widget>[
            if (widget.showSliderText)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  trackType.toString().split('.').last[0].toUpperCase(),
                  style: widget.sliderTextStyle ??
                      Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            Expanded(child: colorPickerSlider(trackType)),
            if (widget.showSliderParams)
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
    ];

    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.showColorIndicator) colorIndicator,
          if (widget.showColorIndicator) space,
          ...sliders,
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

  //WIDGETS
  Widget get colorIndicator {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(widget.colorIndicatorRadius ?? 8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () {
          setState(
            () => currentHsvColor =
                HSVColor.fromColor(widget.currentColor ?? Colors.red),
          );
          widget.onColorChanged?.call(currentHsvColor.toColor());
        },
        child: Container(
          height: widget.colorIndicatorHeight ?? 80,
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: widget.colorIndicatorBorderColor ?? Colors.black,
              width: widget.colorIndicatorBorderWidth ?? 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.colorIndicatorRadius ?? 8),
            ),
            gradient: LinearGradient(
              colors: [
                widget.currentColor ?? Colors.red,
                widget.currentColor ?? Colors.red,
                currentHsvColor.toColor(),
                currentHsvColor.toColor(),
              ],
              begin: widget.colorIndicatorAlignmentBegin,
              end: widget.colorIndicatorAlignmentEnd,
              stops: const [0.0, 0.5, 0.5, 1.0],
            ),
          ),
          child: const CustomPaint(painter: IGCheckerPainter()),
        ),
      ),
    );
  }

  Widget get space {
    return SizedBox(height: widget.elementSpacing);
  }

  Widget colorPickerSlider(IGTrackType trackType) {
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

  //UTILS
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
}
