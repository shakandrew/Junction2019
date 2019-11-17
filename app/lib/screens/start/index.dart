import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenlist/styles.dart';
import 'package:greenlist/widgets/logo.dart';
import 'package:greenlist/widgets/wave.dart';
import 'package:page_transition/page_transition.dart';

import 'second.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  bool inTransition = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            top: true,
            child: Container(
              height: size.width * .18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Logo(size: size.width * .12, color: greenColor),
                  SvgPicture.asset("assets/kMarketLogo.svg", height: 36),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Save the planet together",
              style: genTextStyle(
                greenColor,
                MediaQuery.of(context).size.width * 0.06,
                boldWeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.fastOutSlowIn,
              vsync: this,
              duration: new Duration(seconds: 1),
              child: SizedBox(
                height: inTransition ? size.height * 2 : size.height * .5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inTransition = true;
                    });
                    Future.delayed(Duration(milliseconds: 750)).then((_) {
                      Navigator.of(context).pushReplacement(
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: StartSecondScreen(),
                        ),
                      );
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Wave(),
                      Positioned(
                        top: size.height * .3,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            "start",
                            style: genTextStyle(
                                whiteColor, size.width * .1, boldWeight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
