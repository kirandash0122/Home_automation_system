import 'package:flutter/material.dart';
import '../constants.dart';
class ButtomButton extends StatelessWidget {
  ButtomButton({@required this.buttomtitle,@required this.ontap});
  final String buttomtitle;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(
          child: Text(
            buttomtitle,
            style:kLargetextstyle,
          ),
        ),
        color: kBottomcardcolour,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 80.0,
      ),
    );
  }
}