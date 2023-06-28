// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';

/// Simple round color indicator.
class IGColorIndicator extends StatelessWidget {
  const IGColorIndicator(
    this.hsvColor, {
    super.key,
    this.width = 50.0,
    this.height = 50.0,
    this.radius = 4.0,
  });

  final HSVColor hsvColor;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: hsvColor.toColor(),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: const Color(0xffdddddd)),
      ),
    );
  }
}
