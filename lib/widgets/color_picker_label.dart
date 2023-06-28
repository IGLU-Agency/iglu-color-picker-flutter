// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Provide label for color information.
class IGColorPickerLabel extends StatefulWidget {
  const IGColorPickerLabel(
    this.hsvColor, {
    super.key,
    this.enableAlpha = true,
    this.colorLabelTypes = const [
      IGColorLabelType.hex,
      IGColorLabelType.rgb,
      IGColorLabelType.hsv,
      IGColorLabelType.hsl
    ],
    this.widget,
  });

  final HSVColor hsvColor;
  final bool enableAlpha;
  final List<IGColorLabelType> colorLabelTypes;
  final Widget Function(
    List<String> hex,
    List<String> rgb,
    List<String> hsv,
    List<String> hsl,
  )? widget;

  @override
  IGColorPickerLabelState createState() => IGColorPickerLabelState();
}

class IGColorPickerLabelState extends State<IGColorPickerLabel> {
  final Map<IGColorLabelType, List<String>> _colorTypes = const {
    IGColorLabelType.hex: ['R', 'G', 'B', 'A'],
    IGColorLabelType.rgb: ['R', 'G', 'B', 'A'],
    IGColorLabelType.hsv: ['H', 'S', 'V', 'A'],
    IGColorLabelType.hsl: ['H', 'S', 'L', 'A'],
  };

  IGColorLabelType? _colorType;

  @override
  void initState() {
    super.initState();
    if (widget.colorLabelTypes.isNotEmpty) {
      _colorType = widget.colorLabelTypes[0];
    }
  }

  List<String> colorValue(HSVColor hsvColor, IGColorLabelType colorLabelType) {
    if (colorLabelType == IGColorLabelType.hex) {
      final color = hsvColor.toColor();
      return [
        color.red.toRadixString(16).toUpperCase().padLeft(2, '0'),
        color.green.toRadixString(16).toUpperCase().padLeft(2, '0'),
        color.blue.toRadixString(16).toUpperCase().padLeft(2, '0'),
        color.alpha.toRadixString(16).toUpperCase().padLeft(2, '0'),
      ];
    } else if (colorLabelType == IGColorLabelType.rgb) {
      final color = hsvColor.toColor();
      return [
        color.red.toString(),
        color.green.toString(),
        color.blue.toString(),
        '${(color.opacity * 100).round()}%',
      ];
    } else if (colorLabelType == IGColorLabelType.hsv) {
      return [
        '${hsvColor.hue.round()}°',
        '${(hsvColor.saturation * 100).round()}%',
        '${(hsvColor.value * 100).round()}%',
        '${(hsvColor.alpha * 100).round()}%',
      ];
    } else if (colorLabelType == IGColorLabelType.hsl) {
      final hslColor = hsvToHsl(hsvColor);
      return [
        '${hslColor.hue.round()}°',
        '${(hslColor.saturation * 100).round()}%',
        '${(hslColor.lightness * 100).round()}%',
        '${(hsvColor.alpha * 100).round()}%',
      ];
    } else {
      return ['??', '??', '??', '??'];
    }
  }

  List<Widget> colorValueLabels() {
    if (_colorType != null) {
      final fontSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16;
      return [
        for (String item in _colorTypes[_colorType] ?? [])
          if (widget.enableAlpha || item != 'A')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: fontSize * 2),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          colorValue(widget.hsvColor, _colorType!)[
                              _colorTypes[_colorType]!.indexOf(item)],
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return widget.widget != null
        ? widget.widget?.call(
              colorValue(widget.hsvColor, IGColorLabelType.hex),
              colorValue(widget.hsvColor, IGColorLabelType.rgb),
              colorValue(widget.hsvColor, IGColorLabelType.hsv),
              colorValue(widget.hsvColor, IGColorLabelType.hsl),
            ) ??
            const SizedBox.shrink()
        : _colorType == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    DropdownButton(
                      value: _colorType,
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (IGColorLabelType? type) {
                        if (type != null) setState(() => _colorType = type);
                      },
                      items: [
                        for (IGColorLabelType type in widget.colorLabelTypes)
                          DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.toString().split('.').last.toUpperCase(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(width: 10),
                    ...colorValueLabels(),
                  ],
                ),
              );
  }
}
