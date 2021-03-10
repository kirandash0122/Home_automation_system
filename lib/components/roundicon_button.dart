import 'package:flutter/material.dart';
import '../constants.dart';


class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon,@required this.onpressed});
  final IconData icon;
  final Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: onpressed,
        elevation: 6.0,
        constraints: BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        child: Icon(
          icon,
        ),
        fillColor: Color(0xFF4C4F5E),
        shape: CircleBorder(),
      ),
    );
  }
}
