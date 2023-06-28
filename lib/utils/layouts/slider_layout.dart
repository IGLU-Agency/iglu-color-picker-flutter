// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';

class SliderLayout extends MultiChildLayoutDelegate {
  static const String track = 'track';
  static const String thumb = 'thumb';
  static const String gestureContainer = 'gesturecontainer';

  @override
  void performLayout(Size size) {
    final indicatorOverlflowSize = (size.height * 1.4) - size.height;
    layoutChild(
      track,
      BoxConstraints.tightFor(
        width: size.width - 30.0,
        height: size.height - indicatorOverlflowSize,
      ),
    );
    positionChild(track, Offset(15, indicatorOverlflowSize / 2));
    layoutChild(
      thumb,
      BoxConstraints.tightFor(width: 5, height: size.height * 0.9),
    );
    positionChild(thumb, Offset(0, size.height * 0.5));
    layoutChild(
      gestureContainer,
      BoxConstraints.tightFor(width: size.width, height: size.height),
    );
    positionChild(gestureContainer, Offset.zero);
  }

  @override
  bool shouldRelayout(SliderLayout oldDelegate) => false;
}
