import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.decoration,this.cardchild,this.onpress});

  final Decoration decoration;
  final Widget cardchild;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        child: cardchild,
        margin: EdgeInsets.all(15.0),
        decoration: decoration,
      ),
    );
  }
}