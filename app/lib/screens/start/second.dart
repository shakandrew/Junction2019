import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlist/blocs/index.dart';
import 'package:greenlist/screens/main/index.dart';
import 'package:greenlist/styles.dart';
import 'package:page_transition/page_transition.dart';

import 'widgets/button.dart';

class StartSecondScreen extends StatefulWidget {
  @override
  _StartSecondScreenState createState() => _StartSecondScreenState();
}

class _StartSecondScreenState extends State<StartSecondScreen>
    with TickerProviderStateMixin {
  int selectedMonth;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: greenColor,
      body: SafeArea(
        top: true,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              BlocListener(
                bloc: InitBloc(),
                listener: (context, InitState state) {
                  if (state.inited) {
                    Navigator.of(context).pushReplacement(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: MainScreen(),
                      ),
                    );
                  }
                },
                child: Container(),
              ),
              Positioned(
                top: size.height * .2,
                left: 30,
                right: 30,
                child: Column(
                  children: <Widget>[
                    Text(
                      "choose your plan",
                      style: genTextStyle(
                          whiteColor, size.width * .05, mediumWeight),
                    ),
                    SizedBox(height: 30),
                    MonthButton(
                        value: 1,
                        selectedMonth: selectedMonth,
                        onTap: onMonthsSelected),
                    SizedBox(height: 10),
                    MonthButton(
                        value: 3,
                        selectedMonth: selectedMonth,
                        onTap: onMonthsSelected),
                    SizedBox(height: 10),
                    MonthButton(
                        value: 6,
                        selectedMonth: selectedMonth,
                        onTap: onMonthsSelected),
                    SizedBox(height: 10),
                    MonthButton(
                        value: 12,
                        selectedMonth: selectedMonth,
                        onTap: onMonthsSelected),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "months",
                          style: genTextStyle(whiteColor, size.width * .04),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (selectedMonth != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      InitBloc().add(LoginInitEvent(selectedMonth));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Green mode\nactivated",
                              style: genTextStyle(
                                  whiteColor, size.width * .08, mediumWeight),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "OK",
                              style: genTextStyle(
                                  whiteColor, size.width * .13, mediumWeight),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void onMonthsSelected(int value) {
    setState(() {
      selectedMonth = value;
    });
  }
}
