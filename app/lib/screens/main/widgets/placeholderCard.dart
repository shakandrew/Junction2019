import 'package:flutter/material.dart';
import 'package:greenlist/styles.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderCard extends StatelessWidget {
  final int fade;
  PlaceholderCard({this.fade});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6 - fade.toDouble() * 2,
      child: Container(
        height: 130,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              height: double.infinity,
              child: Shimmer.fromColors(
                baseColor: greenColor.withOpacity(0.8 - .33 * fade),
                highlightColor: Colors.white.withOpacity(0.8 - .33 * fade),
                direction: ShimmerDirection.ltr,
                child: Container(
                  decoration: BoxDecoration(
                    color: greenColor
                        .withOpacity((0.6 - .33 * fade).clamp(0.1, 1)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Shimmer.fromColors(
                  baseColor: greyColor.withOpacity(.6-.3 * fade),
                  highlightColor: Colors.white.withOpacity(0.5),
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(1 - .3 * fade),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
