// IGLU COLOR PICKER EXAMPLE
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

class SlidePickerDetail extends StatefulWidget {
  const SlidePickerDetail({super.key});

  @override
  State<SlidePickerDetail> createState() => _SlidePickerDetailState();
}

class _SlidePickerDetailState extends State<SlidePickerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slide Picker'),
      ),
      body: SingleChildScrollView(
        child: IGSlidePicker(
          currentColor: Colors.red,
          showColorIndicator: true,
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
