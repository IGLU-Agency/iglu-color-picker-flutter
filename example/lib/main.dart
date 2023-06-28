// IGLU COLOR PICKER EXAMPLE
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';
import 'package:iglu_color_picker_flutter/iglu_color_picker_flutter.dart';
import 'package:iglu_color_picker_flutter_example/color_picker_detail.dart';

void main() {
  runApp(const ColorPickerExample());
}

class ColorPickerExample extends StatelessWidget {
  const ColorPickerExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ColorPickerExampleHome(),
    );
  }
}

class ColorPickerExampleHome extends StatefulWidget {
  const ColorPickerExampleHome({super.key});

  @override
  State<ColorPickerExampleHome> createState() => _ColorPickerExampleHomeState();
}

class _ColorPickerExampleHomeState extends State<ColorPickerExampleHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final type = IGPaletteType.values[index];
          return Container(
            height: 44,
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ColorPickerDetail(paletteType: type),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(type.displayName),
                  const Icon(
                    Icons.chevron_right_rounded,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            indent: 20,
            height: 0,
          );
        },
        itemCount: IGPaletteType.values.length,
      ),
    );
  }
}
