import 'package:flutter/material.dart';
import 'package:greenlist/styles.dart';

class Logo extends StatelessWidget {
  final bool save;
  final double size;
  final Color color;
  Logo({this.save = false, this.color = blackColor, this.size});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "GreenList",
            style: genTextStyle(
                color,
                size ?? MediaQuery.of(context).size.width * 0.2,
                boldWeight,
                ntrFontFamily,
                1),
          ),
          if (save)
            Text(
              "Save the planet",
              style: genTextStyle(
                color,
                MediaQuery.of(context).size.width * 0.075,
                boldWeight,
              ),
            )
        ],
      ),
    );
  }
}
