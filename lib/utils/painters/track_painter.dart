// IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';

/// Painter for all kinds of track types.
class IGTrackPainter extends CustomPainter {
  const IGTrackPainter({
    required this.color,
    required this.trackType,
    required this.hsvColor,
    this.radius,
  });

  final Color color;
  final IGTrackType trackType;
  final HSVColor hsvColor;

  final double? radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    switch (trackType) {
      case IGTrackType.hue:
        final colors = <Color>[
          const HSVColor.fromAHSV(1, 0, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 60, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 120, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 180, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 240, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 300, 1, 1).toColor(),
          const HSVColor.fromAHSV(1, 360, 1, 1).toColor(),
        ];
        final Gradient gradient = LinearGradient(colors: colors);

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );

      case IGTrackType.saturation:
        final colors = <Color>[
          HSVColor.fromAHSV(1, hsvColor.hue, 0, 1).toColor(),
          HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor(),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.saturationForHSL:
        final colors = <Color>[
          HSLColor.fromAHSL(1, hsvColor.hue, 0, 0.5).toColor(),
          HSLColor.fromAHSL(1, hsvColor.hue, 1, 0.5).toColor(),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.value:
        final colors = <Color>[
          HSVColor.fromAHSV(1, hsvColor.hue, 1, 0).toColor(),
          HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor(),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.lightness:
        final colors = <Color>[
          HSLColor.fromAHSL(1, hsvColor.hue, 1, 0).toColor(),
          HSLColor.fromAHSL(1, hsvColor.hue, 1, 0.5).toColor(),
          HSLColor.fromAHSL(1, hsvColor.hue, 1, 1).toColor(),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.red:
        final colors = <Color>[
          hsvColor.toColor().withRed(0).withOpacity(1),
          hsvColor.toColor().withRed(255).withOpacity(1),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.green:
        final colors = <Color>[
          hsvColor.toColor().withGreen(0).withOpacity(1),
          hsvColor.toColor().withGreen(255).withOpacity(1),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.blue:
        final colors = <Color>[
          hsvColor.toColor().withBlue(0).withOpacity(1),
          hsvColor.toColor().withBlue(255).withOpacity(1),
        ];
        final Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
      case IGTrackType.alpha:
        final colors = <Color>[
          hsvColor.toColor().withOpacity(0),
          hsvColor.toColor().withOpacity(1),
        ];
        final Gradient gradient = LinearGradient(colors: colors);

        final chessSize = Size(size.height / 2, size.height / 2);
        final chessPaintB = Paint()..color = const Color(0xffcccccc);
        final chessPaintW = Paint()..color = Colors.white;
        final countH = (size.height / chessSize.height).round();
        final countW = ((size.width) / chessSize.width).round();
        List.generate(countH, (int y) {
          List.generate(countW, (int x) {
            canvas.drawRRect(
              RRect.fromRectAndCorners(
                Offset(chessSize.width * x, chessSize.width * y) & chessSize,
                topLeft: x == 0 && y == 0
                    ? Radius.circular(
                        radius ?? 8,
                      )
                    : Radius.zero,
                bottomLeft: x == 0 && y == 1
                    ? Radius.circular(
                        radius ?? 8,
                      )
                    : Radius.zero,
                topRight: x == countW - 1 && y == 0
                    ? Radius.circular(
                        radius ?? 8,
                      )
                    : Radius.zero,
                bottomRight: x == countW - 1 && y == 1
                    ? Radius.circular(
                        radius ?? 8,
                      )
                    : Radius.zero,
              ),
              (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
            );
          });
        });

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            rect,
            Radius.circular(radius ?? 8),
          ),
          Paint()..shader = gradient.createShader(rect),
        );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
