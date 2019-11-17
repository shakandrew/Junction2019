import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenlist/styles.dart';
import 'package:greenlist/widgets/loading.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: height * .2),
            child: Text(
              "GreenList",
              style: genTextStyle(
                  blackColor, width * .15, boldWeight, ntrFontFamily),
            ),
          ),
          ITLoading()
        ],
      ),
    );
  }
}
