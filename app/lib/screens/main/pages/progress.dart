import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlist/blocs/index.dart';
import 'package:greenlist/styles.dart';
import 'package:greenlist/widgets/logo.dart';
import 'package:greenlist/widgets/wave.dart';
import 'package:shimmer/shimmer.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    ChallengeBloc().add(FetchChallengeEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder(
      bloc: ChallengeBloc(),
      builder: (context, ChallengeState state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Text(
                "Save the planet",
                style: genTextStyle(
                  null,
                  MediaQuery.of(context).size.width * 0.075,
                  boldWeight,
                ),
              ),
              Spacer(),
              SizedBox(
                width: size.width * .8,
                height: size.width * .8,
                child: Card(
                  elevation: 8,
                  child: state.score != null
                      ? Stack(
                          children: <Widget>[
                            Wave(),
                            Positioned(
                              bottom: size.width * .2,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    state.score.toString(),
                                    style: genTextStyle(whiteColor,
                                        size.width * .1, boldWeight),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Shimmer.fromColors(
                          baseColor: greenColor.withOpacity(.4),
                          highlightColor: Colors.white.withOpacity(.5),
                          direction: ShimmerDirection.ltr,
                          child: Container(
                            decoration: BoxDecoration(
                              color: greenColor.withOpacity(.5),
                            ),
                          ),
                        ),
                ),
              ),
              Spacer(),
              if (state.score != null)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              "By shopping wisely, you helped to prevent the same amount of carbon emissions as "),
                      TextSpan(
                          text: state.score.toString(),
                          style: genTextStyle(null, null, boldWeight)),
                      TextSpan(text: " trees would have absorbed.\n"),
                      TextSpan(
                          text: state.score < 10 ? "Not bad!" : "Awesome!",
                          style: genTextStyle(null, null, boldWeight)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: genTextStyle(null, bigSize, null, null, 1.3),
                )
              else
                Text(
                  "By shopping wisely, you help the planet to be better place for live.",
                  textAlign: TextAlign.center,
                  style: genTextStyle(null, bigSize, null, null, 1.3),
                ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}
