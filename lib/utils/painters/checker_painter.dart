// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';

/// Painter for chess type alpha background in slider track widget.
class IGCheckerPainter extends CustomPainter {
  const IGCheckerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final chessSize = Size(size.height / 6, size.height / 6);
    final chessPaintB = Paint()..color = const Color(0xffcccccc);
    final chessPaintW = Paint()..color = Colors.white;
    List.generate((size.height / chessSize.height).round(), (int y) {
      List.generate((size.width / chessSize.width).round(), (int x) {
        canvas.drawRect(
          Offset(chessSize.width * x, chessSize.width * y) & chessSize,
          (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
        );
      });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
