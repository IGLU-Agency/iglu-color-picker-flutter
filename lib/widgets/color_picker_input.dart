// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Provide hex input wiget for 3/6/8 digits.
class IGColorPickerInput extends StatefulWidget {
  const IGColorPickerInput({
    required this.color,
    required this.onColorChanged,
    super.key,
    this.enableAlpha = true,
    this.disable = false,
    this.onCurrentColorTap,
    this.radius,
    this.borderWidth,
    this.borderColor,
    this.padding,
    this.inputStyle,
  });

  //CONTAINER DECORATION OPTIONS
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? borderWidth;
  final Color? borderColor;

  final Color color;
  final ValueChanged<Color> onColorChanged;
  final bool enableAlpha;
  final bool disable;
  final void Function()? onCurrentColorTap;
  final TextStyle? inputStyle;

  @override
  IGColorPickerInputState createState() => IGColorPickerInputState();
}

class IGColorPickerInputState extends State<IGColorPickerInput> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  int inputColor = 0;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (inputColor != widget.color.value) {
      textEditingController.text =
          '#${widget.enableAlpha ? widget.color.alpha.toRadixString(16).toUpperCase().padLeft(2, '0') : ''}${widget.color.red.toRadixString(16).toUpperCase().padLeft(2, '0')}${widget.color.green.toRadixString(16).toUpperCase().padLeft(2, '0')}${widget.color.blue.toRadixString(16).toUpperCase().padLeft(2, '0')}';
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius ?? 8),
                border: Border.all(
                  color: widget.borderColor ?? Colors.grey.shade400,
                  width: widget.borderWidth ?? 1.5,
                ),
              ),
              padding:
                  widget.padding ?? const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                focusNode: focusNode,
                enabled: !widget.disable,
                controller: textEditingController,
                style: widget.inputStyle,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: widget.onCurrentColorTap,
                    child: SizedBox(
                      width: 40,
                      child: Center(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: colorFromHex(textEditingController.text),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                onChanged: (String value) {
                  var input = value;
                  if (value.length == 9) {
                    input = value.split('').getRange(7, 9).join() +
                        value.split('').getRange(1, 7).join();
                  }
                  final color = colorFromHex(input);
                  if (color != null) {
                    widget.onColorChanged(color);
                    inputColor = color.value;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
