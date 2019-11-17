import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../styles.dart';

class Wave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        colors: [
          Color(0xFF09782F),
          greenColor.withAlpha(200).withGreen(150).withBlue(50),
          greenColor,
        ],
        durations: [12000, 35000, 19440],
        heightPercentages: [0.20, 0.23, 0.30],
        blur: MaskFilter.blur(BlurStyle.solid, 3),
      ),
      waveAmplitude: 0,
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
