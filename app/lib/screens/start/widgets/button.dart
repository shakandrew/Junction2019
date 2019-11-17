import 'package:flutter/material.dart';
import 'package:greenlist/styles.dart';

class MonthButton extends StatelessWidget {
  final int value;
  final int selectedMonth;
  final Function onTap;
  MonthButton({this.value, this.selectedMonth, this.onTap});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Container(
        height: size.width * .12,
        decoration: BoxDecoration(
          color: selectedMonth == value ? orangeColor : whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: genTextStyle(
            selectedMonth == value ? whiteColor : greenColor,
            size.width * .04,
            boldWeight,
          ),
        ),
      ),
    );
  }
}
