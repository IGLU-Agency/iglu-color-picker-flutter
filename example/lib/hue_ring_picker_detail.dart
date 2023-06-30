// IGLU COLOR PICKER EXAMPLE
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

class HueRingPickerDetail extends StatefulWidget {
  const HueRingPickerDetail({super.key});

  @override
  State<HueRingPickerDetail> createState() => _HueRingPickerDetailState();
}

class _HueRingPickerDetailState extends State<HueRingPickerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hue Ring Picker'),
      ),
      body: SingleChildScrollView(
        child: IGHueRingPicker(
          onColorChanged: (color) {
            if (kDebugMode) {
              print(color);
            }
          },
        ),
      ),
    );
  }
}
