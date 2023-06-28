// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// 9 track types for slider picker widget.
class IGColorPickerSlider extends StatelessWidget {
  const IGColorPickerSlider({
    required this.trackType,
    required this.hsvColor,
    required this.onColorChanged,
    super.key,
    this.displayThumbColor = false,
    this.fullThumbColor = false,
    this.radius,
    this.borderColor,
    this.borderWidth,
    this.mainColor,
  });

  final IGTrackType trackType;
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;
  final bool fullThumbColor;

  final Color? mainColor;

  //DECORATION COLOR PICKER AREA
  final double? radius;
  final Color? borderColor;
  final double? borderWidth;

  void slideEvent(RenderBox getBox, BoxConstraints box, Offset globalPosition) {
    final localDx = getBox.globalToLocal(globalPosition).dx - 15.0;
    final progress =
        localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0);
    switch (trackType) {
      case IGTrackType.hue:
        // 360 is the same as zero
        // if set to 360, sliding to end goes to zero
        onColorChanged(hsvColor.withHue(progress * 359));
      case IGTrackType.saturation:
        onColorChanged(hsvColor.withSaturation(progress));
      case IGTrackType.saturationForHSL:
        onColorChanged(hslToHsv(hsvToHsl(hsvColor).withSaturation(progress)));
      case IGTrackType.value:
        onColorChanged(hsvColor.withValue(progress));
      case IGTrackType.lightness:
        onColorChanged(hslToHsv(hsvToHsl(hsvColor).withLightness(progress)));
      case IGTrackType.red:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor.toColor().withRed((progress * 0xff).round()),
          ),
        );
      case IGTrackType.green:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor.toColor().withGreen((progress * 0xff).round()),
          ),
        );
      case IGTrackType.blue:
        onColorChanged(
          HSVColor.fromColor(
            hsvColor.toColor().withBlue((progress * 0xff).round()),
          ),
        );
      case IGTrackType.alpha:
        onColorChanged(
          hsvColor.withAlpha(
            localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        var thumbOffset = 15.0;
        Color thumbColor;
        switch (trackType) {
          case IGTrackType.hue:
            thumbOffset += (box.maxWidth - 30.0) * hsvColor.hue / 360;
            thumbColor = HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor();
          case IGTrackType.saturation:
            thumbOffset += (box.maxWidth - 30.0) * hsvColor.saturation;
            thumbColor =
                HSVColor.fromAHSV(1, hsvColor.hue, hsvColor.saturation, 1)
                    .toColor();
          case IGTrackType.saturationForHSL:
            thumbOffset +=
                (box.maxWidth - 30.0) * hsvToHsl(hsvColor).saturation;
            thumbColor = HSLColor.fromAHSL(
              1,
              hsvColor.hue,
              hsvToHsl(hsvColor).saturation,
              0.5,
            ).toColor();
          case IGTrackType.value:
            thumbOffset += (box.maxWidth - 30.0) * hsvColor.value;
            thumbColor =
                HSVColor.fromAHSV(1, hsvColor.hue, 1, hsvColor.value).toColor();
          case IGTrackType.lightness:
            thumbOffset += (box.maxWidth - 30.0) * hsvToHsl(hsvColor).lightness;
            thumbColor = HSLColor.fromAHSL(
              1,
              hsvColor.hue,
              1,
              hsvToHsl(hsvColor).lightness,
            ).toColor();
          case IGTrackType.red:
            thumbOffset +=
                (box.maxWidth - 30.0) * hsvColor.toColor().red / 0xff;
            thumbColor = hsvColor.toColor().withOpacity(1);
          case IGTrackType.green:
            thumbOffset +=
                (box.maxWidth - 30.0) * hsvColor.toColor().green / 0xff;
            thumbColor = hsvColor.toColor().withOpacity(1);
          case IGTrackType.blue:
            thumbOffset +=
                (box.maxWidth - 30.0) * hsvColor.toColor().blue / 0xff;
            thumbColor = hsvColor.toColor().withOpacity(1);
          case IGTrackType.alpha:
            thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().opacity;
            thumbColor = hsvColor.toColor().withOpacity(hsvColor.alpha);
        }

        return SizedBox(
          height: 40,
          child: CustomMultiChildLayout(
            delegate: SliderLayout(),
            children: <Widget>[
              LayoutId(
                id: SliderLayout.track,
                child: Container(
                  decoration: BoxDecoration(
                    border: borderColor != null || borderWidth != null
                        ? Border.all(
                            color: borderColor ?? Colors.black,
                            width: borderWidth ?? 3,
                          )
                        : null,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 8),
                    ),
                  ),
                  child: CustomPaint(
                    painter: IGTrackPainter(
                      trackType: trackType,
                      hsvColor: hsvColor,
                      color: mainColor ?? Colors.black,
                      radius: radius != null ? radius! - 3 : 5,
                    ),
                  ),
                ),
              ),
              LayoutId(
                id: SliderLayout.thumb,
                child: Transform.translate(
                  offset: Offset(thumbOffset, 0),
                  child: CustomPaint(
                    painter: IGThumbPainter(
                      thumbColor: displayThumbColor ? thumbColor : null,
                      fullThumbColor: fullThumbColor,
                      color: mainColor ?? Colors.black,
                    ),
                  ),
                ),
              ),
              LayoutId(
                id: SliderLayout.gestureContainer,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints box) {
                    final getBox = context.findRenderObject() as RenderBox?;

                    return Listener(
                      behavior: HitTestBehavior.opaque,
                      onPointerDown: (PointerDownEvent details) {
                        if (getBox != null) {
                          slideEvent(getBox, box, details.position);
                        }
                      },
                      onPointerMove: (event) {
                        if (getBox != null) {
                          slideEvent(getBox, box, event.position);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
