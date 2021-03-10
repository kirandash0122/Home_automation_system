import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
class Iconcontent extends StatelessWidget {
  Iconcontent({
    this.content,this.contenttext,this.active
  });
  final IconData content;
  final String contenttext;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          content,
          size:80.0,
          color: active ?  Colors.white : Color(0xff0288d1),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          contenttext,
          style: GoogleFonts.pacifico(
            textStyle: TextStyle(
              color: active ?  Colors.white : Color(0xff0288d1),
              fontSize: 21.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          // style: TextStyle(
          //   color: active ?  Colors.white : Color(0xff0288d1),
          //   fontSize: 18.0,
          // ),
        )
      ],
    );
  }
}
